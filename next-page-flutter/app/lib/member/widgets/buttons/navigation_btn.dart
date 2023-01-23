import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  const NavigationButton({Key? key, required this.buttonText, required this.route}) : super(key: key);

  final String buttonText;
  final String route;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
      return TextButton(
          onPressed: () {
            Navigator.pushNamed(context, route);
          },
          child: Text(buttonText, style: TextStyle(fontSize: size.width * 0.03))
      );
  }
}