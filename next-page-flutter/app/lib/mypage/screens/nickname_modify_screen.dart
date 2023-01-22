import 'package:app/member/api/requests.dart';
import 'package:app/member/widgets/text_fields/nickname_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../member/api/spring_member_api.dart';
import '../../member/widgets/alerts/custom_result_alert.dart';
import '../../widgets/custom_title_appbar.dart';

class NicknameModifyScreen extends StatefulWidget {
  const NicknameModifyScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NicknameModifyScreenState();
}

class NicknameModifyScreenState extends State<NicknameModifyScreen> {
  final _formKey = GlobalKey<FormState>();
  late int memberId;
  late String newNickname;
  late String currentNickname;

  late TextEditingController nicknameController = TextEditingController();

  final String modifySuccess = "닉네임 변경 되었습니다.";
  final String dupNickname = "중복된 닉네임 입니다.";
  final String noSuchUser = "회원정보를 찾을수 없습니다.";

  @override
  void initState() {
    _asyncMethod();
    nicknameController.addListener(() {
      newNickname = nicknameController.text;
    });

    super.initState();
  }

  void _asyncMethod() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      memberId = prefs.getInt('userId')!;
      currentNickname = prefs.getString('nickname')!;
    });
  }

  @override
  void dispose() {
    nicknameController.dispose();
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
          appBar: customTitleAppbar(context, "닉네임 변경", 99),
          body: Form(
              key: _formKey,
              child: Padding(

                padding: EdgeInsets.all(18.0),
                child: Column(children: [

                  Container(
                      color: Colors.grey.shade100,
                      child: ListTile(
                        title: Text("현재 닉네임"),
                        subtitle: Text(currentNickname, textAlign: TextAlign.end, style: TextStyle(fontSize: 20)),
                      )
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),

                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  ListTile(
                    title: NicknameTextField(
                      controller: nicknameController,
                      label: '새로운 닉네임',
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(size.width * 0.4, size.height * 0.05),
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var result = await SpringMemberApi().modifyNickname(
                              NicknameModifyRequest(memberId, newNickname));
                          debugPrint('result: ' + result);
                          if (result == modifySuccess) {
                            var prefs = await SharedPreferences.getInstance();
                            prefs.setString('nickname', newNickname);
                            setState(() {
                              currentNickname = newNickname;
                            });
                            _showAlertDialog(
                                context,
                                CustomResultAlert(
                                    title: '알림', alertMsg: result));
                          } else if (result == noSuchUser) {
                            _showAlertDialog(
                                context,
                                CustomResultAlert(
                                    title: '알림', alertMsg: result));
                          } else if (result == dupNickname) {
                            _showAlertDialog(
                                context,
                                CustomResultAlert(
                                    title: '알림', alertMsg: result));
                          }
                        } else {
                          _showAlertDialog(
                              context,
                              CustomResultAlert(
                                  title: '알림', alertMsg: '유효한 닉네임을 입력하세요!'));
                        }
                      },
                      child: Text('닉네임 변경하기'))
                ]),
              )),
        ));
  }

  void _showAlertDialog(BuildContext context, Widget alert) {
    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}
