import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../forms/sign_up_form.dart';

class PasswordCheckTextField extends StatefulWidget {
  const PasswordCheckTextField({Key? key}) : super(key: key);

  @override
  State<PasswordCheckTextField> createState() => _PasswordCheckTextFieldState();
}

class _PasswordCheckTextFieldState extends State<PasswordCheckTextField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SignUpFormState? form = context.findAncestorStateOfType<SignUpFormState>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("비밀번호 확인"),
        SizedBox(height: size.height * 0.01),
        TextFormField(
          obscureText: true,
          validator: (value) => value != form?.password ? "비밀번호가 일치하지 않습니다." : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            hintText: "Enter password",
           ),
        )
      ],
    );
  }
}