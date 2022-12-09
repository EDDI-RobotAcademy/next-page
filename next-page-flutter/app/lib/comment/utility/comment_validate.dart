import 'package:flutter/material.dart';

class CommentValidate{
  String? validateComment(FocusNode focusNode, String value) {
    if (value.isEmpty) {
      focusNode.requestFocus();
      return '댓글을 입력해주세요!';
    } else if(!value.isValidComment()){
      return '댓글은 100자 이하로 입력가능합니다.';
    } else{
      return null;
    }
  }
}
extension InputValidate on String {
  bool isValidComment() {
    final commentRegExp = RegExp(
        r'^.{0,100}$');
    return commentRegExp.hasMatch(this);
  }
}