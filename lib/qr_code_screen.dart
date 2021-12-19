import 'dart:io';

import 'package:db_qr_code/details_screen.dart';
import 'package:db_qr_code/intances.dart';
import 'package:db_qr_code/objectbox.g.dart';
import 'package:db_qr_code/qr_code.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeScreen extends StatefulWidget {
  final Function callback;
  const QrCodeScreen({Key? key, required this.callback}) : super(key: key);

  @override
  _QrCodeScreenState createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  var lastScan = null;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Qr Code Scanner"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['jpg', 'png', 'pdf', 'doc'],
                  );

                  if (result != null) {
                    File file = File(result.files.single.path.toString());
                    MyQrCode qrCode = MyQrCode(
                        content: result.files.single.path.toString(),
                        date: DateTime.now(),
                        type: result.files.single.extension,
                        id: 0);
                    widget.callback(qrCode);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                              qrCode: qrCode, callback: widget.callback)),
                    );
                  } else {
                    // User canceled the picker
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.upload),
                    Text("Choisir un fichier")
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      final currentScan = DateTime.now();
      if (lastScan == null ||
          currentScan.difference(lastScan!) > const Duration(seconds: 3)) {
        lastScan = currentScan;
        result = scanData;
        final query = myData.box
            .query(MyQrCode_.content.equals(result!.code.toString()))
            .build();
        final qrCodes = query.find();
        if (qrCodes.length == 0) {
          MyQrCode qrCode = MyQrCode(
              content: result!.code,
              date: DateTime.now(),
              type: 'qrCode',
              id: 0);
          widget.callback(qrCode);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailsScreen(qrCode: qrCode, callback: widget.callback)),
          );
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Key already exists")));
          setState(() {
            myData.qrCodes = myData.box.getAll();
          });
        }
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
