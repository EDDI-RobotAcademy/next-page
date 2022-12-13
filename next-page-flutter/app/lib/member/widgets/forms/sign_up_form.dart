
import 'package:app/member/utility/custom_text_style.dart';
import 'package:app/member/widgets/alerts/custom_result_alert.dart';
import 'package:app/member/widgets/alerts/custom_result_and_push_alert.dart';
import 'package:app/member/widgets/text_fields/email_text_field.dart';
import 'package:app/member/widgets/text_fields/nickname_text_field.dart';
import 'package:app/member/widgets/text_fields/password_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../text_fields/password_check_text_field.dart';


class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => SignUpFormState();
}

class SignUpFormState extends State <SignUpForm>{
  final _formKey = GlobalKey<FormState>();

  late String email;
  late String password;
  late String nickname;

  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  late TextEditingController nicknameController = TextEditingController();

  bool emailPass = false;
  bool nicknamePass = false;
  bool? signUpSuccess = false;

  @override
  void initState() {
    emailController.addListener(() {
      email = emailController.text;
    });
    passwordController.addListener(() {
      password = passwordController.text;
    });
    nicknameController.addListener(() {
      nickname = nicknameController.text;
    });

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nicknameController.dispose();
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
                  const Text("Sign Up", style: largeTextStyleMain),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.1),
                        // 이메일 입력 텍스트 필드 & 중복 확인 버튼
                        Row(
                          children: [
                            Expanded( child: EmailTextField(controller: emailController)),
                            ElevatedButton(
                              onPressed: () async {
                                if(emailController.text.isEmpty) {
                                  _showAlertDialog(context, CustomResultAlert(title: '알림', alertMsg: '내용을 입력해주세요!'));
                                } else {
                                // 이메일 중복 확인 api
                                _showDupCheckResult(context, emailPass, '이메일'); }
                                },
                              child: Text("중복 확인"),)
                          ],
                        ),
                      SizedBox(height: size.height * 0.03),
                      // 닉네임 입력 텍스트 필드 & 중복 확인 버튼
                      Row(
                        children: [
                          Expanded( child: NicknameTextField(controller: nicknameController)),
                          ElevatedButton(
                            onPressed: () {
                              if(nicknameController.text.isEmpty) {
                                _showAlertDialog(context, CustomResultAlert(title: '알림', alertMsg: '내용을 입력해주세요!'));
                              } else {
                              /* 닉네임 중복확인 api */
                              _showDupCheckResult(context, nicknamePass, '닉네임');}},
                            child: Text("중복 확인"),)
                        ],
                      ),
                      SizedBox(height: size.height * 0.03),
                      PasswordTextField(controller: passwordController),
                      SizedBox(height: size.height * 0.03),
                      PasswordCheckTextField(),
                      SizedBox(height: size.height * 0.03),
                      // 회원가입 버튼
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xff6699FF),
                              minimumSize: Size(size.width * 0.4, size.height * 0.05)),
                          onPressed: () {
                            if(_formKey.currentState!.validate()) {
                              if(emailPass == true && nicknamePass == true) {
                                // signUpSuccess = 회원가입 요청 api
                                _showSignUpResult(context);
                              } else {
                                  _showAlertDialog(context, CustomResultAlert(title: '알림', alertMsg: '이메일 혹은 닉네임 중복 여부를 체크해주세요!'));}
                            } else {
                              _showAlertDialog(context, CustomResultAlert(title: '알림', alertMsg: '모두 유효한 값이 입력 되었는지 확인해주세요!'));
                            }
                          },
                          child: Text("회원 가입", style: smallTextStyleWhite)),
                    ],
                  )
                ],
              )
      )
    );
  }
  // 회원가입 결과 알림창 보여주기 메서드
  void _showSignUpResult(BuildContext context) {
    if(signUpSuccess == true) {
      _showAlertDialog(context, CustomResultAndPushAlert(title: '알림', alertMsg: '회원 가입을 축하합니다! \n 로그인 페이지로 이동합니다.', route: 'sign-in'));
    } else {
      _showAlertDialog(context, CustomResultAlert(title: '알림', alertMsg: '통신이 원활하지 않습니다. \n 다시 시도해주세요.'));
    }
  }
  // 중복검사 결과 알림창 보여주기 메서드
  void _showDupCheckResult(BuildContext context, bool result, String type) {
    if(result == true) {
      _showAlertDialog(context, CustomResultAlert(title: '중복 확인', alertMsg: '사용 가능한 $type 입니다.'));
    } else {
      _showAlertDialog(context, CustomResultAlert(title: '중복 확인', alertMsg: '중복되는 $type 입니다.'));}
  }
  // 알림창 보여주기 메서드
  void _showAlertDialog(BuildContext context, Widget alert) {
    showDialog(
        context: context,
        builder: (BuildContext context) => alert);
  }
}