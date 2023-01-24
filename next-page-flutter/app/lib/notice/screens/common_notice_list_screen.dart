import 'package:app/notice/api/notice_requests.dart';
import 'package:app/utility/providers/notice_provider.dart';
import 'package:app/utility/toast_methods.dart';
import 'package:app/widgets/custom_title_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/cupertino_result_alert.dart';
import '../api/notice_responses.dart';
import '../api/spring_notice_api.dart';

class CommonNoticeListScreen extends StatefulWidget {
  const CommonNoticeListScreen({Key? key, required this.nickname}) : super(key: key);
  final String nickname;

  @override
  State<CommonNoticeListScreen> createState() => _CommonNoticeListScreenState();
}

class _CommonNoticeListScreenState extends State<CommonNoticeListScreen> {
  late NoticeProvider _noticeProvider;
  final String adminNickname = 'admin';

  @override
  void initState() {
    _noticeProvider = Provider.of<NoticeProvider>(context, listen: false);
    _noticeProvider.getNoticeList(NoticeRequest(novelInfoId: 0, page: 0, size: 10));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: customTitleAppbar(context, '공지사항'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<NoticeProvider>(
          builder: (context, notice, child) {
            return ListView(
                children:
                  notice.noticelist.isNotEmpty ?
                  notice.noticelist.
                  map((notice) {
                    return noticeListTile(notice, size);}).toList()
                      : [ SizedBox(height: 150,),
                        Center(child: Text("아직 등록한 공지가 없습니다.")) ]
                );
          },
        ),
      ));
  }

  Widget noticeListTile(NoticeResponse notice, Size size) {
    return Column(
      children: [
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            textColor: Colors.black,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: Text("일반",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: size.width * 0.033)),
                    color: Colors.grey.shade300,
                    margin: EdgeInsets.only(right: 5.0),
                    padding: EdgeInsets.all(3.0),
                      ),
                  Text(notice.title, style: TextStyle(fontSize: size.width * 0.04),),
                ],
              ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text( notice.createdDate.substring(0, 9),
                  style: TextStyle(fontSize: size.width * 0.03)),
            ),
            children: [
              ListTile(
                  title: Text(notice.content, style: TextStyle(fontSize: size.width * 0.04)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: size.height * 0.01,),
                      widget.nickname == 'admin' ?
                      TextButton(
                          onPressed: () {
                            _showDeleteDialog(notice);
                          },
                          child: Text('삭제',
                            style: TextStyle(color: Colors.grey),))
                      : Container(),
                        ]),
                      ),
                    ],
                  ),
        ),
        Divider(),
          ],
    );
  }

  void _showDeleteDialog(NoticeResponse notice) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
              title: Text('공지 삭제'),
              content: Text('등록한 공지를 삭제하시겠습니까?'),
              actions: [
                CupertinoDialogAction(
                    onPressed: () async {
                      var result = await SpringNoticeApi().deleteNotice(notice.noticeNo);
                      if(result) {
                        context.read<NoticeProvider>().getNoticeList(
                            NoticeRequest(novelInfoId: 0, page: 0, size: 10));
                        Navigator.pop(context);
                        showToast('공지가 삭제되었습니다.');
                      } else {
                        cupertinoResultAlert(context, '알림', '통신이 원활하지 않습니다.');
                      }
                    },
                    child: const Text('네')
                ),
                CupertinoDialogAction(
                    onPressed: () =>
                        Navigator.pop(context),
                    child: const Text('아니오')
                ),
              ]
          );
        });
  }
}
