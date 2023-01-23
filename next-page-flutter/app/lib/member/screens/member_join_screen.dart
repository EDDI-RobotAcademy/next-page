import 'package:app/home/home_screen.dart';
import 'package:app/member/screens/sign_up_screen.dart';
import 'package:app/widgets/custom_bottom_appbar.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_title_appbar.dart';

class MemberJoinScreen extends StatefulWidget {
  const MemberJoinScreen({Key? key}) : super(key: key);

  @override
  State<MemberJoinScreen> createState() => _MemberJoinScreenState();
}

class _MemberJoinScreenState extends State<MemberJoinScreen> {
  int _counter = 0;
  bool? _Check = false; // 값이 NULL 일수도 있다 라는 뜻

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customTitleAppbar(context,"회원약관동의"),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 30),
              Row(
                children: [
                  Checkbox(
                      value: _Check,
                      onChanged: (value) {
                        setState(() {
                          _Check = value;
                        });
                      }),
                  Text("이용약관,도서관련 정보 수신 동의에 모두 동의합니다.",
                      style: TextStyle(
                        color: Colors.black,
                      ))
                ],
              ),
              Row(
                children: [
                  Checkbox(
                      value: _Check,
                      onChanged: (value) {
                        setState(() {
                          _Check = value;
                        });
                      }),
                  Text("NEXT PAGE 이용약관 동의 (필수)",
                      style: TextStyle(
                        color: Colors.black,
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 130,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF6699FF))),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Center(
                      child: Text(
                        """NEXT - PAGE 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 NEXT-PAGE 서비스의 이용과 관련하여 NEXT-PAGE 서비스를 제공하는 NEXT-PAGE 주식회사(이하 ‘NEXT-PAGE’)와 이를 이용하는 NEXT-PAGE 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며,아울러 여러분의 NEXT-PAGE 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다. 다양한 NEXT-PAGE 서비스를 즐겨보세요.NEXT-PAGE 는 www.NEXT-PAGE.com을 비롯한 NEXT-PAGE 도메인의 웹사이트 및 응용프로그램(어플리케이션, 앱)을 통해 정보 검색, 다른 이용자와의 커뮤니케이션, 콘텐츠 제공, 상품 쇼핑 등 여러분의 생활에 편리함을 더할 수 있는 다양한 서비스를 제공하고 있습니다.여러분은 PC, 휴대폰 등 인터넷 이용이 가능한 각종 단말기를 통해 각양각색의 NEXT-PAGE 서비스를 자유롭게 이용하실 수 있으며, 개별 서비스들의 구체적인 내용은 각 서비스 상의 안내, 공지사항, NEXT-PAGE 웹 고객센터(이하 ‘고객센터’) 도움말 등에서 쉽게 확인하실 수 있습니다. 일부 NEXT-PAGE 서비스의 경우 삭제, 비공개 등의 처리가 어려울 수 있으며, 이러한 내용은 각 서비스 상의 안내, 공지사항, 고객센터 도움말 등에서 확인해 주시길 부탁 드립니다. 여러분은 NEXT-PAGE 서비스 내에 콘텐츠 삭제, 비공개 등의 관리기능이 제공되는 경우 이를 통해 직접 타인의 이용 또는 접근을 통제할 수 있고, 고객센터를 통해서도 콘텐츠의 삭제, 비공개, 검색결과 제외 등의 조치를 요청할 수 있습니다. 여러분이 무심코 게재한 게시물로 인해 타인의 저작권이 침해되거나 명예훼손 등 권리 침해가 발생할 수 있습니다. NEXT-PAGE는 이에 대한 문제 해결을 위해 ‘정보통신망 이용촉진 및 정보보호 등에 관한 법률’ 및 ‘저작권법’ 등을 근거로 권리침해 주장자의 요청에 따른 게시물 게시중단, 원 게시자의 이의신청에 따른 해당 게시물 게시 재개 등을 내용으로 하는 게시중단요청서비스를 운영하고 있습니다. 보다 상세한 내용 및 절차는 고객센터 내 게시중단요청서비스 소개를 참고해 주세요.""",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Checkbox(
                      value: _Check,
                      onChanged: (value) {
                        setState(() {
                          _Check = value;
                        });
                      }),
                  Text("NEXT PAGE 이용약관 동의 (필수)",
                      style: TextStyle(
                        color: Colors.black,
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 130,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF6699FF))),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Center(
                      child: Text(
                        """회원으로 가입하시면 NEXT-PAGE 서비스를 보다 편리하게 이용할 수 있습니다. 여러분은 본 약관을 읽고 동의하신 후 회원 가입을 신청하실 수 있으며, Vellup은 이에 대한 승낙을 통해 회원 가입 절차를 완료하고 여러분께 NEXT-PAGE 서비스 이용 계정(이하 ‘계정’)을 부여합니다. 계정이란 회원이 NEXT-PAGE 서비스에 로그인한 이후 이용하는 각종 서비스 이용 이력을 회원 별로 관리하기 위해 설정한 회원 식별 단위를 말합니다. 회원은 자신의 계정을 통해 좀더 다양한 NEXT-PAGE 서비스를 보다 편리하게 이용할 수 있습니다. 이와 관련한 상세한 내용은 계정 운영정책 및 고객센터 내 NEXT-PAGE 회원가입 방법 등에서 확인해 주세요. NEXT-PAGE는 여러분의 생각과 감정이 표현된 콘텐츠를 소중히 보호할 것을 약속 드립니다. 여러분이 제작하여 게재한 게시물에 대한 지식재산권 등의 권리는 당연히 여러분에게 있습니다. 한편, NEXT-PAGE 서비스를 통해 여러분이 게재한 게시물을 적법하게 제공하려면 해당 콘텐츠에 대한 저장, 복제, 수정, 공중 송신, 전시, 배포, 2차적 저작물 작성(단, 번역에 한함) 등의 이용 권한(기한과 지역 제한에 정함이 없으며, 별도 대가 지급이 없는 라이선스)이 필요합니다. 게시물 게재로 여러분은 NEXT-PAGE 에게 그러한 권한을 부여하게 되므로, 여러분은 이에 필요한 권리를 보유하고 있어야 합니다. 만약, 그 밖의 목적을 위해 부득이 여러분의 콘텐츠를 이용하고자 할 경우엔 사전에 여러분께 설명을 드리고 동의를 받도록 하겠습니다. 또한 여러분이 제공한 소중한 콘텐츠는 NEXT-PAGE 서비스를 개선하고 새로운 NEXT-PAGE 서비스를 제공하기 위해 인공지능 분야 기술 등의 연구 개발 목적으로 NEXT-PAGE 및 NEXT-PAGE 계열사에서 사용될 수 있습니다. NEXT-PAGE는 지속적인 연구 개발을 통해 여러분께 좀 더 편리하고 유용한 서비스를 제공해 드릴 수 있도록 최선을 다하겠습니다. NEXT-PAGE는 여러분이 자신이 제공한 콘텐츠에 대한 NEXT-PAGE 또는 다른 이용자들의 이용 또는 접근을 보다 쉽게 관리할 수 있도록 다양한 수단을 제공하기 위해 노력하고 있습니다. 여러분은 NEXT-PAGE 서비스 내에 콘텐츠 삭제, 비공개 등의 관리기능이 제공되는 경우 이를 통해 직접 타인의 이용 또는 접근을 통제할 수 있고, 고객센터를 통해서도 콘텐츠의 삭제, 비공개, 검색결과 제외 등의 조치를 요청할 수 있습니다. """,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Checkbox(
                      value: _Check,
                      onChanged: (value) {
                        setState(() {
                          _Check = value;
                        });
                      }),
                  Text("NEXT PAGE 이용약관 동의 (필수)",
                      style: TextStyle(
                        color: Colors.black,
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 130,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF6699FF))),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Center(
                      child: Text(
                        """개인정보보호법에 따라 NEXT-PAGE 에 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 개인정보의 보유 및 이용기간, 동의 거부권 및 동의 거부 시 불이익에 관한 사항을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다. 1. 수집하는 개인정보 이용자는 회원가입을 하지 않아도 정보 검색, 뉴스 보기 등 대부분의 NEXT-PAGE 서비스를 회원과 동일하게 이용할 수 있습니다. 이용자가 메일, 캘린더, 카페, 블로그 등과 같이 개인화 혹은 회원제 서비스를 이용하기 위해 회원가입을 할 경우, NEXT-PAGE는 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다. 회원가입 시점에 NEXT-PAGE가 이용자로부터 수집하는 개인정보는 아래와 같습니다. - 회원 가입 시에 ‘아이디, 비밀번호, 닉네임’를 필수항목으로 수집합니다. 만약 이용자가 입력하는 생년월일이 만14세 미만 아동일 경우에는 법정대리인 정보(법정대리인의 이름, 생년월일, 성별, 중복가입확인정보(DI), 휴대전화번호)를 추가로 수집합니다. 그리고 선택항목으로 이메일 주소를 수집합니다. 서비스 이용 과정에서 이용자로부터 수집하는 개인정보는 아래와 같습니다. - 회원정보 또는 개별 서비스에서 프로필 정보(별명, 프로필 사진)를 설정할 수 있습니다. 회원정보에 별명을 입력하지 않은 경우에는 마스킹 처리된 아이디가 별명으로 자동 입력됩니다. 서비스 이용 과정에서 IP 주소, 쿠키, 서비스 이용 기록, 기기정보, 위치정보가 생성되어 수집될 수 있습니다. 또한 이미지 및 음성을 이용한 검색 서비스 등에서 이미지나 음성이 수집될 수 있습니다. 구체적으로 1) 서비스 이용 과정에서 이용자에 관한 정보를 자동화된 방법으로 생성하여 이를 저장(수집)하거나, 2) 이용자 기기의 고유한 정보를 원래의 값을 확인하지 못 하도록 안전하게 변환하여 수집합니다. 서비스 이용 과정에서 위치정보가 수집될 수 있으며, NEXT-PAGE 에서 제공하는 위치기반 서비스에 대해서는 'NEXT-PAGE 위치정보 이용약관'에서 자세하게 규정하고 있습니다. """,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TextButton(
                    child: Text(
                      "CANCEL",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CustomBottomAppbar(routeIndex: 0)));
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xFF6699FF),
                    )),
                SizedBox(
                  width: 50,
                ),
                TextButton(
                  child: Text(
                    "  NEXT  ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    // 네비게이터
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SignUpScreen()));

                  },
                  style:
                      TextButton.styleFrom(backgroundColor: Color(0xFF6699FF)),
                ),
              ])
            ],
          ),
        ));
  }
}
