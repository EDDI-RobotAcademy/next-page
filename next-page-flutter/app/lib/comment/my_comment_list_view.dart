import 'package:app/comment/api/comment_responses.dart';
import 'package:app/utility/providers/comment_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/cupertino_result_alert.dart';
import 'api/spring_comment_api.dart';

class MyCommentListView extends StatefulWidget {
  const MyCommentListView({Key? key, required this.memberId }) : super(key: key);
  final int memberId;

  @override
  State<MyCommentListView> createState() => _MyCommentListViewState();
}

class _MyCommentListViewState extends State<MyCommentListView> {
  late CommentProvider commentProvider;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
        padding: EdgeInsets.all(8.0),
        child: Consumer<CommentProvider>(
              builder: (context, comment, child) {
                 if(comment.memberCommentList.isNotEmpty) {
                   return ListView.separated(
                      itemCount: comment.memberCommentList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildCommentContainer(context,
                            comment.memberCommentList[index], size);
                      },
                      separatorBuilder: (BuildContext context, int index)
                      => const Divider(color: Colors.black,)
              );
            } else {
              return Center(child: Text("작성한 댓글 내역이 없습니다."));
            }
          },
        ),
    );
  }

  Widget _buildCommentContainer(BuildContext context, CommentAndEpisodeResponse commentRes, Size size) {
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
                Text(commentRes.nickName, style: TextStyle(
                    fontSize: size.width * 0.035
                ),),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                Text(commentRes.regDate, style: TextStyle(
                    fontSize: size.width * 0.0315
                ),),
                Spacer(flex: 1),
                Row(
                  children: [
                    // TextButton(onPressed: (){
                    //   print('수정요청');
                    //   setState(() {
                    //     _current = index;
                    //     _onModify = true;
                    //   });
                    // }, child: Text("수정",
                    //     style: TextStyle(
                    //         color: Colors.grey,
                    //         fontSize: size.width * 0.033
                    //     ))),
                    TextButton(onPressed: () async {
                      print("삭제요청");
                      _showDeleteDialog(context: context, title: '알림', content: '댓글을 삭제하시겠습니까?',
                          commentNo: commentRes.commentNo);
                    },
                        child: Text(
                            "삭제",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: size.width * 0.033))
                    )
                  ],
                )
              ],
            ),
          ),
          //본문 내용
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(commentRes.comment,
                  style: TextStyle(
                      fontSize: size.width * 0.033
                  ),),
                SizedBox(height: size.height * 0.02,),
                Text(commentRes.novelTitle+ ", " + commentRes.episodeNumber.toString() + "화 " +
                    "  " + commentRes.episodeTitle,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey, fontSize: size.width * 0.027),),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog({required BuildContext context, String? title, String? content, required int commentNo}) {
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
                  context.read<CommentProvider>().requestMemberCommentList(widget.memberId);
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
