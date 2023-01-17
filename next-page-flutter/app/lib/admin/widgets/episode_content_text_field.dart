import 'package:flutter/material.dart';
import 'package:test1_project/admin/forms/episode_upload_form.dart';

import '../../widgets/rounded_text_field_container.dart';

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
    return RoundedTextFieldContainer(
        size: _superBig,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10,0,10,0),
          child: TextFormField(
            controller: _controller,
            maxLines: null,
            onChanged: (text) {
              form?.content = text;
            },
            decoration: const InputDecoration(
              hintText: '에피소드 본문 입력',
              border: InputBorder.none,

            ),
          ),
        ));
  }
}
