import 'package:app/notice/api/notice_requests.dart';
import 'package:app/utility/providers/notice_provider.dart';
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
                      child: Text("일반", textAlign: TextAlign.center,),
                    color: Colors.grey.shade300,
                    margin: EdgeInsets.only(right: 5.0),
                    padding: EdgeInsets.all(3.0),
                      ),
                  Text(notice.title, style: TextStyle(fontSize: 18),),
                ],
              ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(notice.createdDate.substring(0, 9)),
            ),
            children: [
              ListTile(
                  title: Text(notice.content),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: size.height * 0.01,),
                      widget.nickname == 'admin' ?
                      TextButton(
                          onPressed: () {
                            showAlertDialog(context,
                                AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25.0))),
                                    title: Text('알림'),
                                    content: Text('등록한 공지를 삭제하시겠습니까?'),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('아니오')
                                      ),
                                      TextButton(
                                          onPressed: () async {
                                            var result = await SpringNoticeApi().deleteNotice(notice.noticeNo);
                                            if(result) {
                                              context.read<NoticeProvider>().getNoticeList(
                                                  NoticeRequest(novelInfoId: 0, page: 0, size: 10));
                                              Navigator.pop(context);
                                            } else {
                                              cupertinoResultAlert(context, '알림', '통신이 원활하지 않습니다.');
                                            }
                                          },
                                          child: const Text('네')
                                      )
                                    ]
                                ));
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

  void showAlertDialog(BuildContext context, Widget alert) {
    showDialog(
        context: context,
        builder: (BuildContext context) => alert);
  }
}
