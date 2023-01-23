import 'package:fluttertoast/fluttertoast.dart';

void showToast(String toastMsg) {
  Fluttertoast.showToast(
      msg: toastMsg,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
  );
}