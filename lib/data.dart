import 'package:db_qr_code/objectbox.g.dart';
import 'package:db_qr_code/qr_code.dart';

class MyData {
  List<MyQrCode>? qrCodes = null;
  var box = null;

  data() {}

  Future<void> initDb(Function callback) async {
    this.qrCodes = <MyQrCode>[];
    if (this.box == null) {
      final store = await openStore();
      this.box = store.box<MyQrCode>();
    }
    print("content");
    print(this.box.getAll());
    this.qrCodes?.addAll(this.box.getAll());
    callback(this.qrCodes);
  }
}
