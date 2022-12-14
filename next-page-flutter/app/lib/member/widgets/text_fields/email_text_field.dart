import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utility/check_validate.dart';
import '../forms/sign_up_form.dart';

class EmailTextField extends StatefulWidget {
  const EmailTextField({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    SignUpFormState? form = context.findAncestorStateOfType<SignUpFormState>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("이메일"),
        SizedBox(height: size.height * 0.01,),
        TextFormField(
          controller: widget.controller,
          validator: (value) => CheckValidate().validateEmail(value!),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (text) { form?.emailPass = false; },
          decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          hintText: "Enter Email",
          )
        )
      ],
    );
  }

}