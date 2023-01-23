import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BoardTextField extends StatefulWidget {
  BoardTextField(
      {Key? key,
      required this.usage,
      required this.maxLines,
      required this.controller})
      : super(key: key);

  final String usage;
  final int maxLines;
  final TextEditingController controller;

  @override
  State<BoardTextField> createState() => _BoardTextFieldState();
}

class _BoardTextFieldState extends State<BoardTextField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text( widget.usage,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: size.height * 0.01),
      TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) => value!.isEmpty ? widget.usage + "을 입력하세요" : null,
        maxLines: widget.maxLines,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.usage + "을 입력하세요",
          filled: true,
          fillColor: Colors.grey.shade200,
          border: InputBorder.none
        ),
      ),
    ]);
  }
}
