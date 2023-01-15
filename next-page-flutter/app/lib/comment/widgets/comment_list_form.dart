import 'package:app/comment/api/spring_comment_api.dart';
import 'package:app/widgets/cupertino_result_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utility/providers/comment_provider.dart';
import 'comment_text_form.dart';

class CommentListForm extends StatefulWidget {
  const CommentListForm({Key? key, required this.episodeId}) : super(key: key);
  final int episodeId;

  @override
  State<CommentListForm> createState() => _CommentListFormState();
}

class _CommentListFormState extends State<CommentListForm> {
  int _current = 0;
  bool _onModify = false;
  bool _hasCommentList = false;
  int memberId = 0; //댓글 수정 요청에 필요한 memberId 값
  String nickname = ''; //로그인한 사용자와 댓글 작성자가 같은지 판단하기 위한 닉네임 값

  @override
  void initState() {
    _asyncMethod();
    super.initState();
  }

  void _asyncMethod() async {
    var prefs = await SharedPreferences.getInstance();

    setState(() {
      memberId = prefs.getInt('userId')!;
      nickname = prefs.getString('nickname')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(15,0,15,25),
      child: Column(
        children: <Widget>[
          SizedBox(height: size.height * 0.02,),
          context.watch<CommentProvider>().episodeCommentList!.isEmpty?
          const Expanded(
            child: Center(
              child: Text('아직 댓글이 등록되지 않았습니다.'),
            ),
          )
              :Expanded(
              child: Consumer<CommentProvider>(
                builder: (context, comment, child) {
                  return ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: size.height * 0.18,
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 5, 8),
                                child: Row(
                                  children: [
                                    Text(comment.episodeCommentList![index].nickName, style: TextStyle(
                                        fontSize: size.width * 0.035
                                    ),),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                    ),
                                    Text(comment.episodeCommentList![index].regDate, style: TextStyle(
                                        fontSize: size.width * 0.0315
                                    ),),
                                    Spacer(flex: 1),
                                    nickname == comment.episodeCommentList![index].nickName ?
                                    Row(
                                      children: [
                                        TextButton(onPressed: (){
                                          print('수정요청');
                                          setState(() {
                                            _current = index;
                                            _onModify = true;
                                          });
                                        }, child: Text("수정",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: size.width * 0.033
                                            ))),
                                        TextButton(onPressed: () async {
                                          print("삭제요청");
                                          _showDeleteDialog(title: '알림', content: '댓글을 삭제하시겠습니까?',
                                              commentNo: comment.episodeCommentList![index].commentNo);
                                        },
                                            child: Text(
                                                "삭제",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: size.width * 0.033))
                                        )
                                      ],
                                    )
                                        : Text("")
                                  ],
                                ),
                              ),
                              //본문 내용
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Text(comment.episodeCommentList![index].comment,
                                  style: TextStyle(
                                      fontSize: size.width * 0.033
                                  ),),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(
                        color: Colors.black,
                      ),
                      itemCount: comment.episodeCommentList!.length);
                },
              )),
          Divider(
            thickness: 1,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: CommentTextForm(episodeId: widget.episodeId,),
            // Second child is button
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog({String? title, String? content, required int commentNo}) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title!),
            content: Text(content!),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text("네"),
                onPressed: () async {
                  var deleteResult = await SpringCommentApi().deleteComment(commentNo);
                  context.read<CommentProvider>().requestEpisodeCommentList(widget.episodeId);
                  Navigator.pop(context);
                  if(!deleteResult) {
                    cupertinoResultAlert(context, '알림', '현재 통신이 원활하지 않습니다.');
                  }
                },
              ),
              CupertinoDialogAction(
                isDefaultAction: false,
                child: Text("아니오"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
