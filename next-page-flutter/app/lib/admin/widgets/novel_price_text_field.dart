import 'package:flutter/material.dart';
import '../../widgets/rounded_short_text_field_container.dart';
import '../forms/episode_modify_form.dart';
import '../forms/episode_upload_form.dart';
import '../forms/novel_modify_form.dart';
import '../forms/novel_upload_form.dart';

class NovelPriceTextField extends StatefulWidget {
  final String priceText;


  const NovelPriceTextField({Key? key, required this.priceText}) : super(key: key);

  @override
  State<NovelPriceTextField> createState() => _NovelPriceTextFieldState();
}

class _NovelPriceTextFieldState extends State<NovelPriceTextField> {

  @override
  Widget build(BuildContext context) {
    NovelUploadFormState? form = context.findAncestorStateOfType<NovelUploadFormState>();
    NovelModifyFormState? form2 = context.findAncestorStateOfType<NovelModifyFormState>();
    EpisodeUploadFormState? form3 = context.findAncestorStateOfType<EpisodeUploadFormState>();
    EpisodeModifyFormState? form4 = context.findAncestorStateOfType<EpisodeModifyFormState>();
    TextEditingController _controller = TextEditingController(text: widget.priceText);
    return RoundedShortTextFieldContainer(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20,0,10,0),
          child: TextFormField(
            controller: _controller,
            onChanged: (text) {
              form?.price = text;
              form2?.price = text;
              form3?.episodeNumber = text;
              form4?.episodeNumber = text;
            },
            decoration: const InputDecoration(
                border: InputBorder.none
            ),
          ),
        ));
  }
}
