import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../custom_transparent_appbar.dart';
import '../widgets/forms/sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: customTransparentAppbar(),
            body: SignInForm())
    );
  }
}