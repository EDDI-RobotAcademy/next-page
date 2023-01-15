import 'package:flutter/material.dart';
import '../../widgets/rounded_text_field_container.dart';
import '../forms/novel_modify_form.dart';
import '../forms/novel_upload_form.dart';


class NovelTitleTextField extends StatefulWidget {
  final String titleText;

  const NovelTitleTextField({Key? key, required this.titleText}) : super(key: key);

  @override
  State<NovelTitleTextField> createState() => _NovelTitleTextFieldState();
}

class _NovelTitleTextFieldState extends State<NovelTitleTextField> {
  int _mini = 0;

  @override
  Widget build(BuildContext context) {
    NovelUploadFormState? form = context.findAncestorStateOfType<NovelUploadFormState>();
    NovelModifyFormState? form2 = context.findAncestorStateOfType<NovelModifyFormState>();
    TextEditingController _titleController = TextEditingController(text: widget.titleText);
    return RoundedTextFieldContainer(
      size: _mini,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10,0,10,0),
          child: TextFormField(
            controller: _titleController,
              onChanged: (text) {
                form?.title = text;
                form2?.title = text;
              },
            decoration: const InputDecoration(
              hintText: '소설 제목 입력',
              border: InputBorder.none
            ),
          ),
        ));
  }
}
