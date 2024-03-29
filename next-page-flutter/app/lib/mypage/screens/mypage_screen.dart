import 'package:app/admin/screens/qna_management_screen.dart';
import 'package:app/app_theme.dart';
import 'package:app/notice/screens/common_notice_list_screen.dart';
import 'package:app/notice/screens/notice_management_screen.dart';
import 'package:app/utility/toast_methods.dart';
import 'package:app/widgets/custom_bottom_appbar.dart';
import 'package:app/widgets/custom_title_appbar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../admin/screens/novel_uploade_screen.dart';
import '../../comment/my_comment_list_screen.dart';
import '../../member/api/spring_member_api.dart';
import '../../member/screens/sign_in_screen.dart';
import '../../point/screens/point_charge_screen.dart';
import 'my_info_modify_screen.dart';
import 'qna_screen.dart';

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
  late int currentPoint = 0;
  late int memberId;

  final String adminNickname = 'admin';

  @override
  void initState() {
    _asyncMethod();
    Future.delayed(Duration(milliseconds: 300), () {
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
        memberId = prefs.getInt('userId')!;
        nickname = prefs.getString('nickname')!;
      });
      await SpringMemberApi()
          .lookUpUserPoint(memberId)
          .then((value) => prefs.setInt('point', value));

      setState(() {
        currentPoint = prefs.getInt('point')!;
      });
    } else {
      setState(() {
        _loginState = false;
      });
    }
  }

  Widget _menuCardBasic(String menu, Widget screen) {
    return Card(
        child: ListTile(
          title: Text(menu),
          trailing: Icon(Icons.arrow_forward_ios_rounded),
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => screen)),
        ));
  }

  Widget _menuCardWithButton(String menu, Widget screen, String btnText) {
    return Card(
      child: ListTile(
          title: Text(menu),
          trailing: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => screen));
              },
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: AppTheme.pointColor,
              ),
              child: Text(btnText))),
    );
  }

  Widget _logOutMenuCard() {
    return Card(
      child: ListTile(
          title: Text("로그아웃"),
          trailing: Icon(Icons.arrow_forward_ios_rounded),
          onTap: () {
            showCupertinoDialog(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                    title: Text('알림'),
                    content: Text('로그아웃 하시겠습니까?'),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () async {
                          var prefs = await SharedPreferences.getInstance();
                          prefs.clear();
                          setState(() {
                            _loginState = false;
                          });
                          Get.offAll(()=>CustomBottomAppbar(routeIndex: 0));
                          showToast('로그아웃 되었습니다.');
                        },
                        child: const Text('네'),
                      ),
                      CupertinoDialogAction(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('아니오'),
                      ),
                    ],
                  );
                });
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // stack에 메뉴를 나타내는 위젯 리스트를 쌓아서 보여줍니다.
    final List<Widget> stack = <Widget>[];
    // 로딩 화면
    if (_isLoading) {
      stack.add(Stack(
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
        stack.add(Column(
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            _menuCardWithButton(
                '로그인이 필요합니다.',
                SignInScreen(
                  fromWhere: fromMy,
                  novel: "none",
                  routeIndex: 99,
                ),
                '로그인'),
          ],
        ));
      } else {
        // 관리자 로그인 상태일 때 마이페이지
        if (nickname == adminNickname) {
          stack.add(
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(nickname + '님의 MY PAGE', style: TextStyle(fontSize: 20)),
                    SizedBox(height: size.height * 0.02,),
                    _menuCardBasic('소설 정보 등록', NovelUploadScreen()),
                    _menuCardBasic('고객 QnA 관리', QnaManagementScreen()),
                    _menuCardBasic('일반 공지사항 관리', NoticeManagementScreen(nickname: nickname,)),
                    _logOutMenuCard()
                  ],
                ),
            ),
          );
        } else {
          stack.add(Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(nickname + " 님의 마이페이지", style: TextStyle(fontSize: 20)),
                SizedBox(
                  height: size.height * 0.02,
                ),
                _menuCardWithButton(
                    "보유 포인트: $currentPoint p",
                    PointChargeScreen(
                      fromWhere: fromMy,
                    ),
                    '충전하기'),
                _menuCardBasic('회원 정보 변경', MyInfoModifyScreen()),
                _menuCardBasic('댓글 내역', MyCommentScreen(memberId: memberId)),
                _menuCardBasic('나의 QnA', QnaScreen( memberId: memberId,)),
                _menuCardBasic('공지사항', CommonNoticeListScreen(nickname: nickname)),
                _logOutMenuCard()
              ],
            ),
          ));
        }
      }
    }

    return Scaffold(
      appBar: customTitleAppbar(context, 'MY'),
      body: Stack(children: stack),
    );
  }
}
