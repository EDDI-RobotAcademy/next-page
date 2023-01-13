import 'package:flutter/material.dart';
import '../../widgets/rounded_text_field_container.dart';
import '../forms/novel_upload_form.dart';

class NovelPublisherTextField extends StatefulWidget {
  const NovelPublisherTextField({Key? key}) : super(key: key);

  @override
  State<NovelPublisherTextField> createState() => _NovelPublisherTextFieldState();
}

class _NovelPublisherTextFieldState extends State<NovelPublisherTextField> {
  int _mini = 0;

  @override
  Widget build(BuildContext context) {
    NovelUploadFormState? form = context.findAncestorStateOfType<NovelUploadFormState>();
    return RoundedTextFieldContainer(
      size: _mini,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10,0,10,0),
          child: TextFormField(
            onChanged: (text) {
              form?.publisher = text;
            },
            decoration: const InputDecoration(
              hintText: '출판사명 입력',
              border: InputBorder.none
            ),
          ),
        ));
  }
}
