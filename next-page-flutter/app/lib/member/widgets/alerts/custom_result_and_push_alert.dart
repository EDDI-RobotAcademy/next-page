import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CustomResultAndPushAlert extends StatelessWidget {
  const CustomResultAndPushAlert({Key? key, required this.title, required this.alertMsg, required this.route})
      : super(key: key);

  final String alertMsg;
  final String title;
  final String route;

  @override
  Widget build(BuildContext context) {
        return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            title: Text(title),
            content: Text(alertMsg),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
                },
                child: Text('확인'),
              )
            ]
        );
  }
}