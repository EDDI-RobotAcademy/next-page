import 'package:flutter/material.dart';

class RoundedShortTextFieldContainer extends StatelessWidget {
  final Widget child;

  const RoundedShortTextFieldContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      width: _size.width * 0.2,
      height: _size.height *0.04,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
            color: Colors.grey
        ),
      ),
      child: child,
    );
  }
}
