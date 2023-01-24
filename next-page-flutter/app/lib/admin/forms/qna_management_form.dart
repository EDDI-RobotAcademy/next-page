
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../comment/api/comment_requests.dart';
import '../../mypage/api/responses.dart';
import '../../utility/providers/qna_provider.dart';
import '../../utility/toast_methods.dart';
import '../../widgets/cupertino_result_alert.dart';
import '../../widgets/custom_title_appbar.dart';
import '../api/spring_admin_api.dart';

class QnaManagementForm extends StatefulWidget {
  const QnaManagementForm({Key? key, required this.answered}) : super(key: key);
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: customTitleAppbar(context, widget.answered ? '답변 완료 QnA' : '답변 대기 QnA'),
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
                    height: size.height * 0.04,
                    width: size.width,
                    color: Colors.grey.shade200,
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.01,
                        ),
                        Text(
                          '답변 상태',
                          style: TextStyle(fontSize: size.width * 0.033),
                        ),
                        SizedBox(
                          width: size.width * 0.35,
                        ),
                        Text('QnA 내역',
                            style: TextStyle(fontSize: size.width * 0.033))
                      ],
                    )),
                Divider(
                  thickness: 1,
                  height: 1,
                ),
              ] +
              (answered
                  ? qnaList.map((qna) {
                      return hasCommentQnaListTile(qna, size);
                    }).toList()
                  : qnaList.map((qna) {
                      return noCommentQnaListTile(qna, size);
                    }).toList()));
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
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              textColor: Colors.black,
              leading: Text('대기',
                  style: TextStyle(
                      color: Colors.grey, fontSize: size.width * 0.033)),
              title: Text(qna.title,
                  style: TextStyle(fontSize: size.width * 0.04)),
              subtitle: Text(qna.category,
                  style: TextStyle(fontSize: size.width * 0.033)),
              children: [
                ListTile(
                    title: Text(qna.content,
                        style: TextStyle(fontSize: size.width * 0.04)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text(
                          qna.regDate.substring(0, 10),
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: size.width * 0.03),
                        ),
                        TextButton(
                            onPressed: () {
                              _showAnswerAlert(size, qna);
                            },
                            child: Text(
                              '답변 등록',
                              style: TextStyle(color: Colors.grey),
                            ))
                      ],
                    )),
              ],
            ),
          ),
          Divider()
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
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              leading: Text('완료',
                  style: TextStyle(
                      color: Colors.indigo, fontSize: size.width * 0.033)),
              title: Text(qna.title,
                  style: TextStyle(fontSize: size.width * 0.04)),
              subtitle: Text(qna.category,
                  style: TextStyle(fontSize: size.width * 0.033)),
              children: [
                ListTile(
                  title: Text(qna.content,
                      style: TextStyle(fontSize: size.width * 0.04)),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(qna.regDate.substring(0, 10),
                          style: TextStyle(fontSize: size.width * 0.03)),
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
                        Text(
                          're: 담당자',
                          style: TextStyle(
                              fontSize: size.width * 0.035, color: Colors.grey),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text(qna.comment,
                            style: TextStyle(fontSize: size.width * 0.037)),
                      ],
                    ),
                  ),
                  leading: Icon(Icons.subdirectory_arrow_right),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      qna.hasComment
                          ? Text(
                              qna.commentRegDate.substring(0, 10),
                              style: TextStyle(fontSize: size.width * 0.03),
                            )
                          : Text(''),
                      // qna 답변이 없을 때 regDate가 none 이라 rendering error 방지용
                      TextButton(
                          onPressed: () {
                            _showDeleteAlert(qna);
                          },
                          child: Text(
                            '삭제',
                            style: TextStyle(color: Colors.grey),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  void _showDeleteAlert(QnA qna) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('QnA 답변 삭제'),
            content: Text('해당 QnA 답변을 삭제하시겠습니까?'),
            actions: [
              CupertinoDialogAction(
                child: Text('네'),
                onPressed: () async {
                  await SpringAdminApi().deleteQnaComment(qna.qnaNo);
                  _qnaProvider.requestAllQnaList();
                  Navigator.pop(context);
                  showToast('답변이 삭제되었습니다');
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
                        hintText: "답변을 입력하세요",
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        border: InputBorder.none)),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () async {
                      if (answer != null && answer!.isNotEmpty) {
                        var result = await SpringAdminApi().writeQnaComment(
                            qna.qnaNo,
                            CommentWriteRequest(
                                memberId: memberId, comment: answer!));
                        if (!result) {
                          cupertinoResultAlert(
                              context, '답변 등록 실패', '통신이 원활하지 않습니다.');
                        }
                        answerController.clear();
                        _qnaProvider.requestAllQnaList();
                        Navigator.pop(context);
                        showToast('답변이 등록되었습니다.');
                      } else {
                        cupertinoResultAlert(context, '알림', '답변 내용을 입력해주세요!');
                      }
                    },
                    child: const Text('답변 등록')),
                TextButton(
                    onPressed: () {
                      answerController.clear();
                      Navigator.pop(context);
                    },
                    child: const Text('취소')),
              ]);
        });
  }
}
