import 'package:app/comment/utility/comment_validate.dart';
import 'package:flutter/material.dart';

class CommentTextForm extends StatefulWidget {
  const CommentTextForm({Key? key}) : super(key: key);

  @override
  State<CommentTextForm> createState() => _CommentTextFormState();
}

class _CommentTextFormState extends State<CommentTextForm> {
  FocusNode focusNode = FocusNode();
  final TextEditingController _filter = TextEditingController();
  String _commentText = '';
  final _formKey = GlobalKey<FormState>();

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
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}

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
}
