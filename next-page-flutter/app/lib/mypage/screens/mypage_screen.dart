import 'package:app/member/screens/sign_in_screen.dart';
import 'package:app/member/utility/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../point/screens/point_charge_screen.dart';

class MypageScreen extends StatefulWidget {
  const MypageScreen({Key? key}) : super(key: key);

  @override
  State<MypageScreen> createState() => _MypageScreenState();
}

class _MypageScreenState extends State<MypageScreen> {
  late bool? _loginState;
  bool _isLoading = true;

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
                          // 로그인 페이지에서 돌아올 때 반환값 받기
                          bool isBack = await Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
                          // true(로그인 성공)면 돌아와서 _loginState true로 변경
                          if(isBack) { setState(() { _loginState = true; });}
                          },
                        child: Text('로그인'))),
                ),
                // 화면 전환 확인용 임시 버튼
                /*TextButton(
                    onPressed: () async {
                      var prefs = await SharedPreferences.getInstance();
                      prefs.setString('userToken', 'tmptoken11111');
                      setState(() { _loginState = true; }); },
                    child: Text("로그인 전환"))
                */
              ],
            ));
      } else {
        // 로그인 상태일 때 마이페이지
        stack.add(
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  // 로그인한 사용자의 닉네임 표시할 예정
                  // 로그인한 사용자의 정보(닉네임, 포인트)를 언제 불러올지 고민,,
                  Text("김철수님", style: TextStyle(fontSize: 15)),
                  SizedBox(height: size.height * 0.01,),
                  Card(
                    child: ListTile(
                      title: Text("보유 포인트: ${context.watch<UserDataProvider>().point} p"),
                      trailing: ElevatedButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PointChargeScreen())),
                          child: Text('충전하기'))),
                  ),
                  const Card(
                      child: ListTile(
                        title: Text("회원 정보 변경"),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                        // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => 회원정보 변경 페이지)),
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
                                      prefs.remove('userToken');
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
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            )
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
