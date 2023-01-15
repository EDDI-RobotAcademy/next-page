import 'package:flutter/material.dart';
import '../../widgets/rounded_text_field_container.dart';
import '../forms/novel_modify_form.dart';
import '../forms/novel_upload_form.dart';

class NovelIntroTextField extends StatefulWidget {
  final String introText;

  const NovelIntroTextField({Key? key, required this.introText}) : super(key: key);

  @override
  State<NovelIntroTextField> createState() => _NovelIntroTextFieldState();
}

class _NovelIntroTextFieldState extends State<NovelIntroTextField> {
  int _big = 1;

  @override
  Widget build(BuildContext context) {
    NovelUploadFormState? form = context.findAncestorStateOfType<NovelUploadFormState>();
    NovelModifyFormState? form2 = context.findAncestorStateOfType<NovelModifyFormState>();
    TextEditingController _controller = TextEditingController(text: widget.introText);
    return RoundedTextFieldContainer(
      size: _big,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10,0,10,0),
          child: TextFormField(
            controller: _controller,
            maxLines: null,
            onChanged: (text) {
              form?.intro = text;
              form2?.intro = text;
            },
            decoration: const InputDecoration(
              hintText: '작품 소개 입력',
              border: InputBorder.none,

            ),
          ),
        ));
  }
}
