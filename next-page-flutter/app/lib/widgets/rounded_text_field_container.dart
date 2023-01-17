import 'package:flutter/material.dart';

class RoundedTextFieldContainer extends StatelessWidget {
  final Widget child;
  final int size;

  const RoundedTextFieldContainer(
      {Key? key, required this.child, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      width: _size.width * 0.8,
      height: size == 0
          ? _size.height * 0.06
          : size == 1
          ? _size.height * 0.2
          : _size.height * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.grey),
      ),
      child: child,
    );
  }
}
