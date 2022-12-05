
import 'package:app/member/api/SpringMemberApi.dart';
import 'package:app/member/utility/custom_text_style.dart';
import 'package:app/member/widgets/custom_result_alert.dart';
import 'package:app/member/widgets/text_fields/email_text_field.dart';
import 'package:app/member/widgets/text_fields/password_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../buttons/navigation_btn.dart';


class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State <SignInForm>{
  final _formKey = GlobalKey<FormState>();

  late String email;
  late String password;
  bool testResult = false; //로그인 버튼 테스트용 변수

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
                  const Text("Login", style: largeTextStyleMain),
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
                                // 로그인 요청 api 대신 임의값 넣음
                                signInResponse = await tmpLoginTest(testResult);
                                if(signInResponse.result == true) {
                                  // 이전 페이지로 이동하는 기능 추가 예정
                                  showResultDialog(context, "알림", "로그인 성공!");
                                  testResult = false;
                                } else {
                                  showResultDialog(context, "알림", "존재하지 않는 계정 혹은 비밀번호가 틀렸습니다.");
                                  testResult = true;
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
  // 임의의 response값 넣는 메소드
  Future<SignInResponse> tmpLoginTest(bool success) async {
    Future.delayed(Duration(milliseconds: 500));
    return SignInResponse(success);
  }
}