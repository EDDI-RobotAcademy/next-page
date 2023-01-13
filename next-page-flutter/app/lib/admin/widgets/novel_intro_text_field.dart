import 'package:flutter/material.dart';
import '../../widgets/rounded_text_field_container.dart';
import '../forms/novel_upload_form.dart';

class NovelIntroTextField extends StatefulWidget {
  const NovelIntroTextField({Key? key}) : super(key: key);

  @override
  State<NovelIntroTextField> createState() => _NovelIntroTextFieldState();
}

class _NovelIntroTextFieldState extends State<NovelIntroTextField> {
  int _big = 1;

  @override
  Widget build(BuildContext context) {
    NovelUploadFormState? form = context.findAncestorStateOfType<NovelUploadFormState>();
    return RoundedTextFieldContainer(
      size: _big,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10,0,10,0),
          child: TextFormField(
            maxLines: null,
            onChanged: (text) {
              form?.intro = text;
            },
            decoration: const InputDecoration(
              hintText: '작품 소개 입력',
              border: InputBorder.none,

            ),
          ),
        ));
  }
}
