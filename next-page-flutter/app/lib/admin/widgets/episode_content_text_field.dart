import 'package:flutter/material.dart';
import '../../widgets/rounded_text_field_container.dart';
import '../forms/episode_modify_form.dart';
import '../forms/episode_upload_form.dart';

class EpisodeContentTextField extends StatefulWidget {
  final String content;

  const EpisodeContentTextField({Key? key, required this.content}) : super(key: key);

  @override
  State<EpisodeContentTextField> createState() => _EpisodeContentTextFieldState();
}

class _EpisodeContentTextFieldState extends State<EpisodeContentTextField> {
  final _superBig = 2;

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController(text: widget.content);
    EpisodeUploadFormState? form = context.findAncestorStateOfType<EpisodeUploadFormState>();
    EpisodeModifyFormState? form2 = context.findAncestorStateOfType<EpisodeModifyFormState>();
    return RoundedTextFieldContainer(
        size: _superBig,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10,0,10,0),
          child: TextFormField(
            controller: _controller,
            maxLines: null,
            onChanged: (text) {
              form?.content = text;
              form2?.content = text;
            },
            decoration: const InputDecoration(
              hintText: '에피소드 본문 입력',
              border: InputBorder.none,

            ),
          ),
        ));
  }
}
