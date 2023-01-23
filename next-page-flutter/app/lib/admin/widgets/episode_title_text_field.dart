import 'package:flutter/material.dart';
import 'package:test1_project/admin/forms/episode_modify_form.dart';
import '../../widgets/rounded_text_field_container.dart';
import '../forms/episode_upload_form.dart';


class EpisodeTitleTextField extends StatefulWidget {
  final String titleText;

  const EpisodeTitleTextField({Key? key, required this.titleText}) : super(key: key);

  @override
  State<EpisodeTitleTextField> createState() => _EpisodeTitleTextFieldState();
}

class _EpisodeTitleTextFieldState extends State<EpisodeTitleTextField> {
  int _mini = 0;

  @override
  Widget build(BuildContext context) {
    EpisodeUploadFormState? form = context.findAncestorStateOfType<EpisodeUploadFormState>();
    EpisodeModifyFormState? form2 = context.findAncestorStateOfType<EpisodeModifyFormState>();
    TextEditingController controller = TextEditingController(text: widget.titleText);
    return RoundedTextFieldContainer(
      size: _mini,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10,0,10,0),
          child: TextFormField(
            controller: controller,
              onChanged: (text) {
                form?.episodeTitle = text;
                form2?.episodeTitle = text;
              },
            decoration: const InputDecoration(
              hintText: '에피소드 제목 입력',
              border: InputBorder.none
            ),
          ),
        ));
  }
}
