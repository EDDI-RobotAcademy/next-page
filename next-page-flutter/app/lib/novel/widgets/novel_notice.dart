import 'package:app/notice/api/notice_requests.dart';
import 'package:app/notice/api/spring_notice_api.dart';
import 'package:app/widgets/cupertino_result_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_theme.dart';
import '../../utility/providers/notice_provider.dart';

class NovelNotice extends StatefulWidget {
  const NovelNotice({Key? key, required this.novelInfoId}) : super(key: key);
  final int novelInfoId;

  @override
  State<NovelNotice> createState() => _NovelNoticeState();
}

class _NovelNoticeState extends State<NovelNotice> {
  String? nickname;

  @override
  void initState() {
    _asyncMethod();
    super.initState();
  }

  void _asyncMethod() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      nickname = prefs.getString('nickname');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
          child: Consumer<NoticeProvider>(
            builder: (context, notice, child) {
              return Column (children:
              notice.noticelist.isNotEmpty ?
              notice.noticelist.map((notice){
                  return noticeCardList(notice);
                }).toList()
                : [ SizedBox(height: 150,),
                  Center(child: Text("등록된 공지가 없습니다.")) ]
              );
            }
          ),
        )
    );
  }
  Widget noticeCardList(dynamic notice) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(19),
          bottomLeft: Radius.circular(19)
      ),
      child: Card(
        color: AppTheme.chalk,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Container(
                      child: Text(notice.noticeCategory == "COMMON" ?
                        '일반' : notice.noticeCategory == "EVENT" ?
                        '이벤트' : '휴재',
                        textAlign: TextAlign.center,),
                      color: Colors.grey.shade300,
                      margin: EdgeInsets.only(right: 5.0),
                      padding: EdgeInsets.all(3.0),
                    ),
                    Text(notice.title, style: TextStyle(fontSize: 18),),
                    Text(
                      notice.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17
                      ),
                    ),
                    const Spacer(flex: 1,),
                    Text(notice.createdDate.substring(0, 9), style: const TextStyle(
                      color: Colors.black26,
                    ),)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(notice.content),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    nickname == 'admin' ?
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
                                                NoticeRequest(novelInfoId: widget.novelInfoId, page: 0, size: 10));
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
                          style: TextStyle(color: Colors.black26),))
                        : Container(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context, Widget alert) {
    showDialog(
        context: context,
        builder: (BuildContext context) => alert);
  }
}
