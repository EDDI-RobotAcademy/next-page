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
    if (qnaList == null || qnaList.isEmpty) {
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
                    Text('답변 상태', style: TextStyle(fontSize: size.width * 0.033)),
                    SizedBox(width: size.width * 0.35,),
                    Text('QnA 내역', style: TextStyle(fontSize: size.width * 0.033))
                  ],
                )),
            Divider(thickness: 1, height: 1,),
          ] + qnaList.map((qna) {
            return myQnaListTile(qna, size);
          }).toList());
    }
  }

  Widget myQnaListTile(QnA qna, Size size) {

    return Column(
      children: [
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            textColor: Colors.black,
            leading: qna.hasComment
                ? Text('완료', style: TextStyle(color: Colors.indigo, fontSize: size.width * 0.033))
                : Text('대기', style: TextStyle(color: Colors.grey, fontSize: size.width * 0.033)),
            title: Text(qna.title, style: TextStyle(fontSize: size.width * 0.04),),
            subtitle: Text(qna.category, style: TextStyle(fontSize: size.width * 0.033),),
            children: [
              ListTile(
                  title: Text(qna.content, style: TextStyle(fontSize: size.width * 0.04)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: size.height * 0.03,),
                      Text( qna.regDate.substring(0,10),
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: size.width * 0.03),),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Visibility(
                              visible: !qna.hasComment,
                              child: TextButton(
                                  onPressed: () {
                                    _showDeleteAlert(qna);
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
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('re: 담당자',
                          style: TextStyle(fontSize: size.width * 0.035, color: Colors.grey),),
                        SizedBox(height: size.height * 0.01,),
                        Text(qna.comment, style: TextStyle(fontSize: size.width * 0.037),),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        qna.hasComment ? Text(qna.commentRegDate.substring(0,10),
                          style: TextStyle(fontSize: size.width * 0.03),)
                            : Text(''),
                      ],
                    ),
                    leading: Icon(Icons.subdirectory_arrow_right),
                  )
              )
            ],
          ),
        ),
        Divider()
      ],
    );
  }

  void _showDeleteAlert(QnA qna) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('QnA 삭제'),
            content: Text('해당 QnA를 삭제하시겠습니까?'),
            actions: [
              CupertinoDialogAction(
                child: Text('네'),
                onPressed: () async {
                  await SpringMyPageApi()
                      .deleteQna(qna.qnaNo);
                  popPopPush(context, QnaScreen(memberId: widget.memberId));
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

