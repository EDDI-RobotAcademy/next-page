import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../custom_transparent_appbar.dart';
import '../widgets/forms/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: customTransparentAppbar(),
            body: SingleChildScrollView(
              child: SignUpForm() ),
            )
    );
  }
}