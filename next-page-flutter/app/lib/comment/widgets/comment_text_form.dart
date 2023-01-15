import 'package:app/comment/api/comment_requests.dart';
import 'package:app/comment/api/spring_comment_api.dart';
import 'package:app/comment/utility/comment_validate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utility/providers/comment_provider.dart';

class CommentTextForm extends StatefulWidget {
  const CommentTextForm({Key? key, required this.episodeId}) : super(key: key);
  final int episodeId;

  @override
  State<CommentTextForm> createState() => _CommentTextFormState();
}

class _CommentTextFormState extends State<CommentTextForm> {
  FocusNode focusNode = FocusNode();
  final TextEditingController _filter = TextEditingController();
  String _commentText = '';
  final _formKey = GlobalKey<FormState>();

  int memberId = 0; // 댓글 등록 요청에 필요한 memberId

  @override
  void initState() {
    _asyncMethod();
    super.initState();
  }

  void _asyncMethod() async {
    var prefs = await SharedPreferences.getInstance();

    setState(() {
      memberId = prefs.getInt('userId')!;
    });
  }

  _CommentTextFormState() {
    _filter.addListener(() {
      setState(() {
        _commentText = _filter.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        children: [
          Expanded(
              flex: 6,
              child: TextFormField(
                validator: (value) => CommentValidate().validateComment(focusNode, value!),
                //autovalidateMode: AutovalidateMode.onUserInteraction,
                focusNode: focusNode,
                style: const TextStyle(fontSize: 15),
                autofocus: false,
                controller: _filter,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[300],
                    suffixIcon: focusNode.hasFocus
                        //댓글창내의 x자 버튼 (텍스트필드내의 텍스트값 초기화)
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                _filter.clear();
                                _commentText = '';
                              });
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.black54,
                              size: 20,
                            ))
                        : Container(),
                    hintText: "댓글을 입력해주세요.",
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              )),
          focusNode.hasFocus
              ? Expanded(
                  //댓글 작성버튼
                  child: TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var writeResult =
                      await SpringCommentApi().writeComment(widget.episodeId,
                          CommentWriteRequest(memberId: memberId, comment: _commentText));
                      context.read<CommentProvider>().requestEpisodeCommentList(widget.episodeId);
                      if(!writeResult) {
                        _showResultDialog(title: "알림", content: "통신이 원활하지 않습니다.\u{1F622}\n 잠시 후 다시 시도해주세요");
                      }
                    }
                    setState(() {
                      _filter.clear();
                      _commentText = '';
                      focusNode.unfocus();
                    });
                  },
                  child: const Text(
                    '작성',
                    style: TextStyle(color: Colors.black),
                  ),
                ))
              : Expanded(flex: 0, child: Container())
        ],
      ),
    );
  }
  void _showResultDialog({String? title, String? content}) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title!),
            content: Text(content!),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text("확인"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
