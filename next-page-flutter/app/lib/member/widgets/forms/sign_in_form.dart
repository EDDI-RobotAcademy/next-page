

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../novel/screens/novel_detail_screen.dart';
import '../../../widgets/custom_bottom_appbar.dart';
import '../../api/spring_member_api.dart';
import '../../api/requests.dart';
import '../../api/responses.dart';
import '../../utility/custom_text_style.dart';
import '../buttons/navigation_btn.dart';
import '../alerts/custom_result_alert.dart';
import '../text_fields/email_text_field.dart';
import '../text_fields/password_text_field.dart';


class SignInForm extends StatefulWidget {
  final int fromWhere;
  final dynamic novel;
  const SignInForm({Key? key, required this.fromWhere, required this.novel}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State <SignInForm>{
  final _formKey = GlobalKey<FormState>();

  final int homeIdx = 0;
  final int myIdx = 4;
  final int fromEpisode = 5;

  late String email;
  late String password;

  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  late SignInResponse signInResponse;

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
        child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("로그인", style: largeTextStyleMain),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.1),
                      EmailTextField(controller: emailController),
                      SizedBox(height: size.height * 0.03),
                      PasswordTextField(controller: passwordController),
                      SizedBox(height: size.height * 0.03),
                      ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xff6699FF),
                                minimumSize: Size(size.width * 0.4, size.height * 0.05)),
                            onPressed: () async {
                              if(_formKey.currentState!.validate()) {
                                signInResponse = await SpringMemberApi().signIn(SignInRequest(email, password));
                                if(signInResponse.result == true) {
                                  if(widget.fromWhere == myIdx) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                CustomBottomAppbar(routeIndex: myIdx,)),
                                            (route) => false);
                                  } else if(widget.fromWhere == fromEpisode) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                        builder: (BuildContext context) => NovelDetailScreen(id: widget.novel.id)));
                                  } else {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                CustomBottomAppbar(routeIndex: homeIdx)),
                                            (route) => false);
                                  }

                                } else {
                                  showResultDialog(context, "알림", "이메일 혹은 비밀번호가 올바르지 않습니다.");
                                }
                              } else {
                                showResultDialog(context, "알림", "유효한 값을 모두 입력해주세요!");
                              }
                            }, child: Text("로그인", style: smallTextStyleWhite)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NavigationButton(buttonText: "계정 찾기", route: "/find-account",),
                          SizedBox(height: size.height * 0.03, child: VerticalDivider(thickness: 1)),// 세로 구분선
                          NavigationButton(buttonText: "비밀번호 찾기", route: "/find-password",),
                          SizedBox(height: size.height * 0.03, child: VerticalDivider(thickness: 1)),// 세로 구분선
                          NavigationButton(buttonText: "회원 가입", route: "/sign-up",)
                        ])
                    ],
                  )
                ],
              )
      )
    );
  }
  void showResultDialog(BuildContext context, String title, String alertMsg) {
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            CustomResultAlert(title: title, alertMsg: alertMsg));
  }
}