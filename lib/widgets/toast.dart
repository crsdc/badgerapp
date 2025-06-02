import 'package:fluttertoast/fluttertoast.dart';

toastCopied() {
  return Fluttertoast.showToast(
    msg: 'Copied to clipboard',
    toastLength: Toast.LENGTH_SHORT,
  );
}

toastCustom(String msg) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
  );
}
