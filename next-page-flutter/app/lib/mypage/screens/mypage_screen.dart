
import 'package:app/member/screens/sign_in_screen.dart';
import 'package:app/mypage/screens/my_info_modify_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../point/screens/point_charge_screen.dart';

class MypageScreen extends StatefulWidget {
  const MypageScreen({Key? key}) : super(key: key);

  @override
  State<MypageScreen> createState() => _MypageScreenState();
}

class _MypageScreenState extends State<MypageScreen> {
  bool _loginState = false;
  bool _isLoading = true;
  final int fromMy = 4;
  late String nickname;
  late int currentPoint;

  @override
  void initState() {
    _asyncMethod();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  void _asyncMethod() async {
    var prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');

    if (userToken != null) {
      setState(() {
        _loginState = true;
        nickname = prefs.getString('nickname')!;
        currentPoint = prefs.getInt('point')!;
      });
    } else {
      setState(() {
        _loginState = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // stack에 메뉴를 나타내는 위젯 리스트를 쌓아서 보여줍니다.
    final List<Widget> stack = <Widget>[];
    // 로딩 화면
    if(_isLoading) {
      stack.add(
          Stack(
            children: const <Widget>[
              Opacity(
                opacity: 0.3,
                child: ModalBarrier(dismissible: false, color: Colors.grey),
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ));
    } else {
      // 비로그인 상태일 떄 마이페이지
      if (_loginState == false) {
        stack.add(
            ListView(
              children: [
                SizedBox(height: size.height * 0.03,),
                Card(
                  child: ListTile(
                    title: Text("로그인이 필요합니다."),
                    trailing: ElevatedButton(
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignInScreen(fromWhere: fromMy, novel: "none", routeIndex: 99,)));
                          },
                        child: Text('로그인'))),
                ),
              ],
            ));
      } else {
        // 로그인 상태일 때 마이페이지
        stack.add(
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Text(nickname + "님", style: TextStyle(fontSize: 20)),
                  SizedBox(height: size.height * 0.01,),
                  Card(
                    child: ListTile(
                      title: Text("보유 포인트: $currentPoint p"),
                      trailing: ElevatedButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PointChargeScreen(fromWhere: fromMy,))),
                          child: Text('충전하기'))),
                  ),
                  Card(
                      child: ListTile(
                        title: Text("회원 정보 변경"),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyInfoModifyScreen())),
                      )
                  ),
                  const Card(
                      child: ListTile(
                        title: Text("소설 구매 내역"),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                        // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => 소설 구매 내역 페이지)),
                      )
                  ),
                  const Card(
                    child: ListTile(
                      title: Text("댓글 내역"),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                      // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => 댓글 내역 페이지)),
                    ),
                  ),
                  Card(
                    child: ListTile(
                        title: Text("로그아웃"),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                        onTap: () {
                          _showAlertDialog(context,
                              AlertDialog(
                                title: Text('알림'),
                                content: Text('로그아웃 하시겠습니까?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('아니오'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      var prefs = await SharedPreferences
                                          .getInstance();
                                      prefs.clear();
                                      setState(() {
                                        _loginState = false;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: const Text('네'),
                                  ),
                                ],
                              ));
                        }
                    ),
                  ),
                ],
              ),
            )
        );
      }
      }

    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: Text("MY"),
        ),
        body: Stack(
            children: stack
        )
    );
  }
  void _showAlertDialog(BuildContext context, Widget alert) {
    showDialog(
        context: context,
        builder: (BuildContext context) => alert);
  }
}
