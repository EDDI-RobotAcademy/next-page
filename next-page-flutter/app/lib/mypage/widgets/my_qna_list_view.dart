import 'package:app/utility/page_navigate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utility/providers/qna_provider.dart';
import '../api/responses.dart';
import '../api/spring_mypage_api.dart';
import '../screens/qna_screen.dart';

class MyQnaListView extends StatefulWidget {
  const MyQnaListView({Key? key, required this.memberId}) : super(key: key);
  final int memberId;

  @override
  State<MyQnaListView> createState() => _MyQnaListViewState();
}

class _MyQnaListViewState extends State<MyQnaListView> {
  late QnaProvider _qnaProvider;

  @override
  void initState() {
    super.initState();
    _qnaProvider = Provider.of<QnaProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(5.0),
            child: _buildQnaList(_qnaProvider.myQnaList, size)));
  }

  Widget _buildQnaList(List<QnA>? qnaList, Size size) {
    if (qnaList == null) {
      return Center(child: Text("작성한 QnA 내역이 존재하지 않습니다."));
    } else {
      return ListView(
          children: <Widget>[
            // qna 리스트 제목
            Container(
                height: size.height * 0.04,
                width: size.width,
                color: Colors.grey.shade200,
                child: Row(
                  children: [
                    SizedBox(width: size.width * 0.01,),
                    Text('답변 상태', style: TextStyle(fontSize: 13),),
                    SizedBox(width: size.width * 0.35,),
                    Text('QnA 내역')
                  ],
                )),
            Divider(thickness: 1, height: 1,),
          ] + qnaList.map((qna) {
            return myQnaListTile(qna, size);
          }).toList());
    }
  }

  Widget myQnaListTile(QnA qna, Size size) {
    var regDate = qna.regDate.split('T')[0];

    return Column(
      children: [
        ExpansionTile(
          leading: qna.hasComment
              ? Text('완료', style: TextStyle(color: Colors.indigo))
              : Text('대기', style: TextStyle(color: Colors.grey)),
          title: Text(qna.title),
          subtitle: Text(qna.category),
          children: [
            Divider(),
            ListTile(
                title: Text(qna.content),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: size.height * 0.03,),
                    Text('등록일 : ' + regDate, textAlign: TextAlign.end,),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Visibility(
                            visible: !qna.hasComment,
                            child: TextButton(
                                onPressed: () {
                                  showAlertDialog(context,
                                      AlertDialog(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25.0))),
                                          title: Text('알림'),
                                          content: Text('등록한 QnA를 삭제하시겠습니까?'),
                                          actions: <Widget>[
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text('아니오')
                                            ),
                                            TextButton(
                                                onPressed: () async {
                                                  // qna 삭제 요청 api
                                                  await SpringMyPageApi()
                                                      .deleteQna(qna.qnaNo);
                                                  popPopPush(context,
                                                      QnaScreen(memberId: widget.memberId));
                                                },
                                                child: const Text('네')
                                            )
                                          ]
                                      ));
                                },
                                child: Text('삭제',
                                  style: TextStyle(color: Colors.grey),)),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            Visibility(
                visible: qna.hasComment,
                child: ListTile(
                  tileColor: Colors.grey.shade100,
                  title: Text('관리자 답변', style: TextStyle(fontSize: 15),),
                  leading: Icon(Icons.subdirectory_arrow_right),
                  subtitle: Text(qna.comment),
                )
            )
          ],
        ),
      ],
    );
  }
  void showAlertDialog(BuildContext context, Widget alert) {
    showDialog(
        context: context,
        builder: (BuildContext context) => alert);
  }
}

