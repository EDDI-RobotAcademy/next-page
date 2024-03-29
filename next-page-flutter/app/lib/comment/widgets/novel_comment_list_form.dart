import 'package:app/comment/api/spring_comment_api.dart';
import 'package:app/widgets/cupertino_result_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utility/providers/comment_provider.dart';
import '../../utility/toast_methods.dart';

class NovelCommentListForm extends StatefulWidget {
  const NovelCommentListForm({Key? key, required this.novelInfoId}) : super(key: key);
  final int novelInfoId;

  @override
  State<NovelCommentListForm> createState() => _NovelCommentListFormState();
}

class _NovelCommentListFormState extends State<NovelCommentListForm> {
  int _current = 0;
  bool _onModify = false;
  bool _hasCommentList = false;
  int memberId = 0; //댓글 수정 요청에 필요한 memberId 값
  String nickname = ''; //로그인한 사용자와 댓글 작성자가 같은지 판단하기 위한 닉네임 값

  @override
  void initState(){
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
          context.watch<CommentProvider>().novelCommentList!.isEmpty?
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
                          height: size.height * 0.15,
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 5, 8),
                                child: Row(
                                  children: [
                                    Text(comment.novelCommentList![index].nickName, style: TextStyle(
                                        fontSize: size.width * 0.035
                                    ),),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                    ),
                                    Text(comment.novelCommentList![index].regDate, style: TextStyle(
                                        fontSize: size.width * 0.0315
                                    ),),
                                    Spacer(flex: 1),
                                    nickname == comment.novelCommentList![index].nickName ?
                                    Row(
                                      children: [
                                        TextButton(onPressed: () async {
                                          print("삭제요청");
                                          _showDeleteDialog(title: '알림', content: '댓글을 삭제하시겠습니까?',
                                              commentNo: comment.novelCommentList![index].commentNo);
                                        },
                                            child: Text(
                                                "삭제",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: size.width * 0.033))
                                        )
                                      ],
                                    )
                                        : TextButton(onPressed: () {  },
                                        child: Text(""),)
                                  ],
                                ),
                              ),
                              //본문 내용
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(comment.novelCommentList![index].comment,
                                      style: TextStyle(
                                          fontSize: size.width * 0.033
                                      ),),
                                    SizedBox(height: size.height * 0.02,),
                                    Text(comment.novelCommentList![index].episodeNumber.toString() + "화 " +
                                    "  " + comment.novelCommentList![index].episodeTitle,
                                      overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.grey),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(
                        color: Colors.black,
                      ),
                      itemCount: comment.novelCommentList!.length);
                },
              )),
          Divider(
            thickness: 1,
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
                  context.read<CommentProvider>().requestNovelCommentList(widget.novelInfoId);
                  Navigator.pop(context);
                  if(!deleteResult) {
                    cupertinoResultAlert(context, '알림', '현재 통신이 원활하지 않습니다.');
                  }
                  showToast('댓글이 삭제되었습니다.');
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
