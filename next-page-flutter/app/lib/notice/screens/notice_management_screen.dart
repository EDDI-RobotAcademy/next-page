import 'package:app/notice/notice_upload_form.dart';
import 'package:app/notice/screens/common_notice_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_title_appbar.dart';

class NoticeManagementScreen extends StatefulWidget {
  const NoticeManagementScreen({Key? key, required this.nickname}) : super(key: key);
  final String nickname;

  @override
  State<NoticeManagementScreen> createState() => _NoticeManagementScreenState();
}

class _NoticeManagementScreenState extends State<NoticeManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customTitleAppbar(context, '일반 공지사항 관리', 99),
      body: Card(
        child: Column(
          children: [
            _menuListTileWithDivide("일반 공지사항 등록",
                NoticeUploadForm(novelInfoId: 0,)),
            _menuListTileWithDivide("일반 공지사항 목록 보기",
                CommonNoticeListScreen(nickname: widget.nickname)),
          ],
        ),
      ),
    );
  }

  Widget _menuListTileWithDivide(String menu, Widget screen) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
          title: Text(menu),
          trailing: Icon(Icons.arrow_forward_ios_rounded),
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => screen))),
          const Divider(thickness: 1, height: 1,),
      ],
    );
  }
}
