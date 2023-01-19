import 'package:app/admin/api/spring_admin_api.dart';
import 'package:app/comment/api/comment_requests.dart';
import 'package:app/widgets/custom_title_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../member/widgets/alerts/custom_result_alert.dart';
import '../../mypage/api/responses.dart';
import '../../utility/providers/qna_provider.dart';

class QnaManagementForm extends StatefulWidget {
  const QnaManagementForm({Key? key, required this.answered }) : super(key: key);
  final bool answered;

  @override
  State<QnaManagementForm> createState() => _QnaManagementFormState();
}

class _QnaManagementFormState extends State<QnaManagementForm> {
  late QnaProvider _qnaProvider;
  String? answer;
  late int memberId;

  TextEditingController answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _qnaProvider = Provider.of<QnaProvider>(context, listen: false);
    _qnaProvider.requestAllQnaList();
    _asyncMethod();
  }

  _QnaManagementFormState() {
    answerController.addListener(() {
      setState(() {
        answer = answerController.text;
      });
    });
  }

  void _asyncMethod() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      memberId = prefs.getInt('userId')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery .of(context).size;
    return Scaffold(
      appBar: customTitleAppbar(context, widget.answered ? '답변 완료 QnA' : '답변 대기 QnA', 9999),
      body: Consumer<QnaProvider>(
            builder: (context, qna, child) {
              return Padding(
                  padding: EdgeInsets.all(5.0),
                  child: _buildQnaList(qna.allQnaList, size, widget.answered));
            }
          )
    );
  }
  Widget _buildQnaList(List<QnA>? qnaList, Size size, bool answered) {
    if (qnaList != null && qnaList.isNotEmpty) {
      return ListView(
          children: <Widget>[
            // qna 리스트 제목
            Container(
                height: size.height * 0.07,
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
          ] + (answered ? qnaList.map((qna) {
            return hasCommentQnaListTile(qna, size);
          }).toList()
              : qnaList.map((qna) {
            return noCommentQnaListTile(qna, size);
          }).toList())
      );
    } else {
      return Center(child: Text("QnA 내역이 존재하지 않습니다."));
    }
  }
  // 답변 대기중인 qna 리스트
  Widget noCommentQnaListTile(QnA qna, Size size) {

    return Visibility(
      visible: !qna.hasComment,
      child: Column(
        children: [
          ExpansionTile(
            leading: Text('대기', style: TextStyle(color: Colors.grey)),
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
                      Text( qna.regDate.substring(0,10), textAlign: TextAlign.end,),
                      TextButton(
                          onPressed: () {
                            _showAnswerAlert(size, qna);
                          },
                          child: Text('답변 등록하기',
                            style: TextStyle(color: Colors.grey),))
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
  // 답변 완료된 qna 리스트
  Widget hasCommentQnaListTile(QnA qna, Size size) {

    return Visibility(
      visible: qna.hasComment,
      child: Column(
        children: [
          ExpansionTile(
            leading: Text('완료', style: TextStyle(color: Colors.indigo)),
            title: Text(qna.title),
            subtitle: Text(qna.category),
            children: [
              Divider(),
              ListTile(
                  title: Text(qna.content),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(qna.regDate.substring(0,10)),
                    ],
                  ),
              ),
              ListTile(
                tileColor: Colors.grey.shade100,
                title: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('관리자 답변', style: TextStyle(fontSize: 15, color: Colors.grey),),
                      SizedBox(height: size.height * 0.01,),
                      Text(qna.comment),
                    ],
                  ),
                ),
                leading: Icon(Icons.subdirectory_arrow_right),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    qna.hasComment ? Text(qna.commentRegDate.substring(0,10))
                    : Text(''), // qna 답변이 없을 때 regDate가 none 이라 rendering error 방지용
                    TextButton(
                        onPressed: () {
                          _showAlertDialog(context,
                              AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25.0))),
                                  title: Text('알림'),
                                  content: Text('등록한 답변을 삭제하시겠습니까?'),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context),
                                        child: const Text('아니오')
                                    ),
                                    TextButton(
                                        onPressed: () async {
                                          // qna 삭제 요청 api
                                          await SpringAdminApi()
                                              .deleteQnaComment(qna.qnaNo);
                                          _qnaProvider.requestAllQnaList();
                                          Navigator.pop(context);
                                        },
                                        child: const Text('네')
                                    )
                                  ]
                              ));
                        },
                        child: Text('삭제',
                          style: TextStyle(color: Colors.grey),)),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
  void _showAlertDialog(BuildContext context, Widget alert) {
    showDialog(
        context: context,
        builder: (BuildContext context) => alert);
  }

  void _showAnswerAlert(Size size, QnA qna) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('답변 등록'),
          content: Container(
            width: size.width * 0.8,
            child: TextFormField(
              maxLines: 10,
              controller: answerController,
              decoration: InputDecoration(
              hintText: "딥변을 입력하세요",
              filled: true,
              fillColor: Colors.grey.shade200,
              border: InputBorder.none
              )),
          ),
          actions: <Widget>[
            TextButton(
            onPressed: () async {
              if(answer != null && answer!.isNotEmpty) {
                var result = await SpringAdminApi().writeQnaComment(qna.qnaNo,
                    CommentWriteRequest(memberId: memberId, comment: answer!));
                if(!result) {
                  _showAlertDialog(context,
                      CustomResultAlert(title: '알림', alertMsg: '통신이 원활하지 않습니다.'));
                }
                answerController.clear();
                _qnaProvider.requestAllQnaList();
                Navigator.pop(context);
              } else {
                _showAlertDialog(context,
                    CustomResultAlert(title: '알림', alertMsg: '답변 내용을 입력해주세요!'));
              }


            },
            child: const Text('답변 등록')),
            TextButton(
                onPressed: () {
                  answerController.clear();
                  Navigator.pop(context);
                },
                child: const Text('취소')
            ),
       ] );
      });
}
}



