import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../custom_transparent_appbar.dart';
import '../widgets/forms/sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  final int fromWhere;
  final dynamic novel;
  const SignInScreen({Key? key, required this.fromWhere, required this.novel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: customTransparentAppbar(),
            // overflow 나서 SingleChildScrollView 추가
            body: SingleChildScrollView(
              child: SignInForm(fromWhere: fromWhere,novel: novel,),
            ))
    );
  }
}