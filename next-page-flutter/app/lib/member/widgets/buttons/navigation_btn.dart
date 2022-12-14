import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  const NavigationButton({Key? key, required this.buttonText, required this.route}) : super(key: key);

  final String buttonText;
  final String route;

  @override
  Widget build(BuildContext context) {
      return TextButton(
          onPressed: () {
            Navigator.pushNamed(context, route);
          },
          child: Text(buttonText)
      );
  }
}