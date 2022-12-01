
import 'package:app/member/utility/custom_text_style.dart';
import 'package:app/member/widgets/text_fields/email_text_field.dart';
import 'package:app/member/widgets/text_fields/password_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State <SignInForm>{
  final _formKey = GlobalKey<FormState>();

  late String email;
  late String password;

  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    emailController.addListener(() {
      email = emailController.text;
    });
    passwordController.addListener(() {
      password = passwordController.text;
    });

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Container(
        height: size.height,
        padding: EdgeInsets.all(16.0),
        // color: Colors.tealAccent,
        child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Login", style: CustomTextStyle.title),
                  SizedBox(height: size.height * 0.1),
                  EmailTextField(controller: emailController),
                  SizedBox(height: size.height * 0.03),
                  PasswordTextField(controller: passwordController),
                ],
              )
      )
    );
  }
}