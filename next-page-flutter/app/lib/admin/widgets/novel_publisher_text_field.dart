import 'package:flutter/material.dart';
import '../../widgets/rounded_text_field_container.dart';
import '../forms/novel_modify_form.dart';
import '../forms/novel_upload_form.dart';

class NovelPublisherTextField extends StatefulWidget {
  final String publisherText;

  const NovelPublisherTextField({Key? key, required this.publisherText}) : super(key: key);

  @override
  State<NovelPublisherTextField> createState() => _NovelPublisherTextFieldState();
}

class _NovelPublisherTextFieldState extends State<NovelPublisherTextField> {
  int _mini = 0;

  @override
  Widget build(BuildContext context) {
    NovelUploadFormState? form = context.findAncestorStateOfType<NovelUploadFormState>();
    NovelModifyFormState? form2 = context.findAncestorStateOfType<NovelModifyFormState>();
    TextEditingController _controller = TextEditingController(text: widget.publisherText);
    return RoundedTextFieldContainer(
      size: _mini,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10,0,10,0),
          child: TextFormField(
            controller: _controller,
            onChanged: (text) {
              form?.publisher = text;
              form2?.publisher = text;
            },
            decoration: const InputDecoration(
              hintText: '출판사명 입력',
              border: InputBorder.none
            ),
          ),
        ));
  }
}
