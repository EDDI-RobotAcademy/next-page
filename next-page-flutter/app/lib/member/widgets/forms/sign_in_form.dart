
import 'package:app/member/api/SpringMemberApi.dart';
import 'package:app/member/api/requests.dart';
import 'package:app/member/utility/user_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../api/responses.dart';
import '../../utility/custom_text_style.dart';
import '../buttons/navigation_btn.dart';
import '../alerts/custom_result_alert.dart';
import '../text_fields/email_text_field.dart';
import '../text_fields/password_text_field.dart';


class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State <SignInForm>{
  final _formKey = GlobalKey<FormState>();

  late String email;
  late String password;

  late UserDataProvider _userDataProvider;

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
    _userDataProvider = Provider.of<UserDataProvider>(context, listen: false);

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
    debugPrint("loginState: " + _userDataProvider.loginState.toString());
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
                                  // spring서버가 응답한 token값을 provider class의 userToken에 저장
                                  _userDataProvider.setUserToken(signInResponse.userToken.toString());
                                  debugPrint("provider userToken: " + _userDataProvider.userToken.toString());
                                  _userDataProvider.isLogin();
                                  debugPrint("loginState: " + _userDataProvider.loginState.toString());
                                  // 이전 페이지로 이동하는 기능 추가 예정
                                  showResultDialog(context, "알림", "로그인 성공!");
                                } else {
                                  showResultDialog(context, "알림", signInResponse.userToken.toString());
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