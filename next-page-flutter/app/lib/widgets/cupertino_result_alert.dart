import 'package:flutter/cupertino.dart';

void cupertinoResultAlert(BuildContext context, String title, String content) {
  showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            CupertinoDialogAction(
              child: Text('확인'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      });
}