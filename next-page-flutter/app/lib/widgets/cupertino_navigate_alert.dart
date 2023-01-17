import 'package:app/utility/page_navigate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void cupertinoNavigateAlert(
    BuildContext context, String content, Widget nextScreen, Widget currentScreen) {
  showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('알림'),
          content: Text(content),
          actions: [
            CupertinoDialogAction(
              child: Text('네'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => nextScreen));
              },
            ),
            CupertinoDialogAction(
              child: Text('아니오'),
              onPressed: () {
                popPopPush(context, currentScreen);
              },
            )
          ],
        );
      });
}