import 'package:app/widgets/cupertino_result_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../api/spring_member_api.dart';
import '../../api/requests.dart';
import '../../utility/custom_text_style.dart';
import '../alerts/custom_result_and_push_alert.dart';
import '../text_fields/email_text_field.dart';
import '../text_fields/nickname_text_field.dart';
import '../text_fields/password_check_text_field.dart';
import '../text_fields/password_text_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  late String email;
  String password = ''; //LateInitializationError 때문에 late -> ''값으로 초기화
  late String nickname;

  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  late TextEditingController nicknameController = TextEditingController();

  bool? emailPass;
  bool? nicknamePass;
  bool? signUpSuccess;

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
            padding: EdgeInsets.all(18.0),
            child: Column(
              children: [
                Container(
                  child: Image.asset('assets/images/logo/logo2.png'),
                  height: 180,
                  width: 500,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.04),
                    // 이메일 입력 텍스트 필드 & 중복 확인 버튼
                    Row(
                      children: [
                        Expanded(
                            child: EmailTextField(controller: emailController)),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xff6699FF),
                              minimumSize:
                                  Size(size.width * 0.2, size.height * 0.045)),
                          onPressed: () async {
                            if (emailController.text.isEmpty) {
                              cupertinoResultAlert(
                                  context, '알림', '내용을 입력해 주세요');
                            } else {
                              emailPass =
                                  await SpringMemberApi().emailCheck(email);
                              debugPrint(emailPass.toString());
                              _showDupCheckResult(context, emailPass, '이메일');
                            }
                          },
                          child: Text("중복 확인"),
                        )
                      ],
                    ),
                    SizedBox(height: size.height * 0.03),
                    // 닉네임 입력 텍스트 필드 & 중복 확인 버튼
                    Row(
                      children: [
                        Expanded(
                            child: NicknameTextField(
                          controller: nicknameController,
                          label: '닉네임',
                        )),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xff6699FF),
                              minimumSize:
                                  Size(size.width * 0.2, size.height * 0.045)),
                          onPressed: () async {
                            if (nicknameController.text.isEmpty) {
                              cupertinoResultAlert(
                                  context, '알림', '내용을 이력해주세요!');
                            } else {
                              debugPrint("nickname:" + nickname);
                              nicknamePass = await SpringMemberApi()
                                  .nicknameCheck(nickname);
                              debugPrint(nicknamePass.toString());
                              _showDupCheckResult(context, nicknamePass, '닉네임');
                            }
                          },
                          child: Text("중복 확인"),
                        )
                      ],
                    ),
                    SizedBox(height: size.height * 0.03),
                    PasswordTextField(
                      controller: passwordController,
                      label: '비밀번호',
                    ),
                    SizedBox(height: size.height * 0.03),
                    PasswordCheckTextField(password: password),
                    SizedBox(height: size.height * 0.03),
                    // 회원가입 버튼
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff6699FF),
                            minimumSize:
                                Size(size.width * 0.4, size.height * 0.053)),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (emailPass == true && nicknamePass == true) {
                              signUpSuccess = await SpringMemberApi().signUp(
                                  SignUpRequest(email, password, nickname));
                              debugPrint(signUpSuccess.toString());
                              _showSignUpResult(context);
                            } else {
                              cupertinoResultAlert(
                                  context, '알림', '이메일 혹은 닉네임 중복 여부를 체크해 주세요!');
                            }
                          } else {
                            cupertinoResultAlert(
                                context, '알림', '모두 유효한 값이 입력 되었는지 확인 부탁드립니다.');
                          }
                        },
                        child: Text("회원 가입", style: smallTextStyleWhite)),
                  ],
                )
              ],
            )));
  }

  // 회원가입 결과 알림창 보여주기 메서드
  void _showSignUpResult(BuildContext context) {
    if (signUpSuccess == true) {
      _showAlertDialog(
          context,
          CustomResultAndPushAlert(
              title: '알림',
              alertMsg: '회원 가입을 축하합니다! \n로그인 페이지로 이동합니다.',
              route: '/sign-in'));
    } else {
      cupertinoResultAlert(context, '알림', '통신이 원할하지 않습니다.\n다시 시도해주세요. ');
    }
  }

  // 중복검사 결과 알림창 보여주기 메서드
  void _showDupCheckResult(BuildContext context, bool? result, String type) {
    if (result == true) {
      cupertinoResultAlert(context, '중복 확인', '사용가능한 $type 입니다.');
    } else {
      cupertinoResultAlert(context, '중복 확인', '중복되는 $type 입니다.');
    }
  }

  // 알림창 보여주기 메서드
  void _showAlertDialog(BuildContext context, Widget alert) {
    // 안 메서드가 알럿을 띄워주는 역할
    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}
