import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utility/check_validate.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({Key? key, required this.controller, required this.label}) : super(key: key);
  final TextEditingController controller;
  final String label;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        SizedBox(height: size.height * 0.01),
        TextFormField(
          controller: widget.controller,
          obscureText: !_passwordVisible,
          validator: (value) => CheckValidate().validatePassword(value!),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            hintText: "Enter password",
              suffixIcon: IconButton(
                icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              )
           ),
        )
      ],
    );
  }
}