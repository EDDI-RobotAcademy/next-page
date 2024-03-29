import 'package:app/member/api/requests.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_theme.dart';
import '../../member/api/spring_member_api.dart';
import '../../member/widgets/text_fields/password_text_field.dart';
import '../../widgets/cupertino_result_alert.dart';
import '../../widgets/custom_title_appbar.dart';

class PasswordModifyScreen extends StatefulWidget {
  const PasswordModifyScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PasswordModifyScreenState();
}

class PasswordModifyScreenState extends State<PasswordModifyScreen> {
  final _formKey = GlobalKey<FormState>();
  late int memberId;
  late String newPassword;

  late TextEditingController newPasswordController = TextEditingController();

  @override
  void initState() {
    _asyncMethod();
    newPasswordController.addListener(() {
      newPassword = newPasswordController.text;
    });
    super.initState();
  }

  void _asyncMethod() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      memberId = prefs.getInt('userId')!;
    });
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: customTitleAppbar(context, "비밀번호 변경"),
          body: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(18.0),
                child: Column(children: [
                  ListTile(
                    title: PasswordTextField(
                      controller: newPasswordController,
                      label: '새 비밀번호',
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  ElevatedButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size(size.width * 0.4, size.height * 0.05),
                        backgroundColor: AppTheme.pointColor,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          bool result = await SpringMemberApi().modifyPassword(
                              PasswordModifyRequest(memberId, newPassword));
                          debugPrint('result: ' + result.toString());
                          if (result) {
                            cupertinoResultAlert(context, '알림', '비밀번호가 변경되었습니다.');
                          } else {
                            cupertinoResultAlert(context, '알림', '통신 문제로 비밀번호 변경에 실패했습니다.');
                          }
                        } else {
                          cupertinoResultAlert(context, '알림', '유효한 값을 입력해주세요!');
                        }
                      },
                      child: Text('비밀번호 변경하기'))
                ]),
              )),
        ));
  }
}
