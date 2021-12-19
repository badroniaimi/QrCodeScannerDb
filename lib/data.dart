import 'package:db_qr_code/objectbox.g.dart';
import 'package:db_qr_code/qr_code.dart';

class MyData {
  List<MyQrCode>? qrCodes = null;
  var box = null;

  data() {}

  Future<void> initDb(Function callback) async {
    qrCodes = <MyQrCode>[];
    if (box == null) {
      final store = await openStore();
      box = store.box<MyQrCode>();
    }
    qrCodes?.addAll(box.getAll());
    callback(qrCodes);
  }
}
