
import 'package:app/member/api/spring_member_api.dart';
import 'package:app/member/widgets/alerts/custom_result_alert.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/custom_bottom_appbar.dart';

class MyInfoModifyScreen extends StatefulWidget {
  const MyInfoModifyScreen({Key? key}) : super(key: key);

  @override
  State<MyInfoModifyScreen> createState() => _MyInfoModifyScreenState();
}

class _MyInfoModifyScreenState extends State<MyInfoModifyScreen> {
  String email = '';

  @override
  void initState() {
    _asyncMethod();
    super.initState();
  }

  void _asyncMethod() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email')!;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: Text("회원 정보 변경"),
      ),
      body: Padding(
          padding: EdgeInsets.all(0.0),
          child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("로그인 계정 정보"),
                        subtitle: Text(email),
                      ),
                      const Divider(),
                      const ListTile(
                        title: Text("닉네임 변경하기"),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                        // onTap: () => Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => NicknameModifyScreen())),
                      ),
                      const Divider(),
                      const ListTile(
                        title: Text("비밀번호 변경하기"),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                        // onTap: () => Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => //비밀번호 변경 페이지)),
                      ),
                      const Divider(),
                      ListTile(
                        title: Text("회원 탈퇴"),
                        onTap: () {
                          _showAlertDialog(context,
                              AlertDialog(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                                title: Text('알림'),
                                content: Text('정말 탈퇴 하시겠습니까?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('아니오', style: TextStyle(fontWeight: FontWeight.w400)),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      var prefs = await SharedPreferences.getInstance();
                                      var userId = prefs.getInt('userId');
                                      var result = await SpringMemberApi().deleteMember(userId!);

                                      if(result) {
                                        prefs.clear();
                                        _showAlertDialog(context,
                                            _pushToHomeAlert('회원 탈퇴가 완료되었습니다. \n확인을 누르면 홈화면으로 이동합니다.'));
                                      } else {
                                          _showAlertDialog(context,
                                          CustomResultAlert(title: '알림', alertMsg: '서버가 불안정합니다. \n다시 시도해주세요.'));
                                      }
                                    },
                                    child: const Text('네'),
                                  ),
                                ],
                          ));
                        }
                      ),
                    ],
                  )
          )
      )
    );
  }

  void _showAlertDialog(BuildContext context, Widget alert) {
    showDialog(
        context: context,
        builder: (BuildContext context) => alert);
  }

  Widget _pushToHomeAlert(String msg) {
    return AlertDialog(
      title: Text('알림'),
      content: Text(msg),
      actions: <Widget>[
        TextButton(
          onPressed: () => 
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          CustomBottomAppbar(routeIndex: 0,)),
                      (route) => false),
        child: Text("확인"),
        )
      ],
    );
  }
}
