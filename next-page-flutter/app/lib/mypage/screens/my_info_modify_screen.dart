
import 'package:app/member/api/spring_member_api.dart';
import 'package:app/mypage/screens/password_modify_screen.dart';
import 'package:app/utility/toast_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/custom_bottom_appbar.dart';
import '../../widgets/custom_title_appbar.dart';
import 'nickname_modify_screen.dart';

class MyInfoModifyScreen extends StatefulWidget {
  const MyInfoModifyScreen({Key? key}) : super(key: key);

  @override
  State<MyInfoModifyScreen> createState() => _MyInfoModifyScreenState();
}

class _MyInfoModifyScreenState extends State<MyInfoModifyScreen> {
  String email = '';
  final int myIdx = 4;

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
      appBar: customTitleAppbar(context,"회원정보변경"), // 앱바 변경
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(0.0),
                    child: Column(
                      children: [
                        Container(
                          child: Image.asset('assets/images/logo/logo2.png'),
                          height: 180,
                          width: 500,
                        ),
                        SizedBox(height: 10),

                        ListTile(
                          title: Text("로그인 계정 정보"),
                          subtitle: Text(email),
                        ),
                        const Divider(thickness: 1, height: 1,),
                        ListTile(
                          contentPadding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                          title: Text("닉네임 변경하기"),
                          trailing: Icon(Icons.arrow_forward_ios_rounded),
                          onTap: () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) => NicknameModifyScreen())),
                        ),
                        const Divider(thickness: 1, height: 1,),
                         ListTile(
                          contentPadding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                          title: Text("비밀번호 변경하기"),
                          trailing: Icon(Icons.arrow_forward_ios_rounded),
                          onTap: () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) => PasswordModifyScreen())),
                        ),
                        const Divider(thickness: 1, height: 1,),
                        ListTile(
                          contentPadding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                          title: Text("회원 탈퇴", style: TextStyle(color: Colors.grey),),
                          onTap: () {
                            _showDeleteAccountAlert(context);
                          }
                        ),
                        const Divider(thickness: 1, height: 1,),
                      ],
                    )
            ),
      )
    );
  }

  void _showDeleteAccountAlert(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('회원 탈퇴'),
            content: Text('탈퇴 시 NEXT PAGE의 서비스를\n이용할 수 없게 됩니다.\n정말 탈퇴 하시겠습니까?'),
            actions: [
              CupertinoDialogAction(
                child: Text('네'),
                onPressed: () async {
                  var prefs = await SharedPreferences.getInstance();
                  var userId = prefs.getInt('userId');
                  var result = await SpringMemberApi().deleteMember(userId!);

                  if(result){
                    print('탈퇴 완');
                    prefs.clear();
                    showToast('회원 탈퇴가 완료되었습니다.');
                    Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            CustomBottomAppbar(routeIndex: 0,)),
                        (route) => false);
                  } else {
                    showToast('통신 오류');
                  }
                },
              ),
              CupertinoDialogAction(
                child: Text('아니오'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
