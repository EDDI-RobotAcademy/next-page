import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/rounded_text_field_container.dart';
import '../forms/novel_modify_form.dart';
import '../forms/novel_upload_form.dart';



class NovelAuthorTextField extends StatefulWidget {
  final String authorText;

  const NovelAuthorTextField({Key? key, required this.authorText}) : super(key: key);

  @override
  State<NovelAuthorTextField> createState() => _NovelAuthorTextFieldState();
}

class _NovelAuthorTextFieldState extends State<NovelAuthorTextField> {
  int _mini = 0;


  @override
  Widget build(BuildContext context) {
    NovelUploadFormState? form = context.findAncestorStateOfType<NovelUploadFormState>();
    NovelModifyFormState? form2 = context.findAncestorStateOfType<NovelModifyFormState>();
    TextEditingController _controller = TextEditingController(text: widget.authorText);
    return RoundedTextFieldContainer(
        size: _mini,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
          child: TextFormField(
            controller: _controller,
            onChanged: (text) {
              form?.author = text;
              form2?.author = text;
            },
            decoration: const InputDecoration(
                hintText: '작가명 입력',
                border: InputBorder.none),
          ),
        ));
  }
}
