import 'package:flutter/material.dart';
import '../../widgets/rounded_short_text_field_container.dart';
import '../forms/novel_upload_form.dart';

class NovelPriceTextField extends StatefulWidget {
  const NovelPriceTextField({Key? key}) : super(key: key);

  @override
  State<NovelPriceTextField> createState() => _NovelPriceTextFieldState();
}

class _NovelPriceTextFieldState extends State<NovelPriceTextField> {

  @override
  Widget build(BuildContext context) {
    NovelUploadFormState? form = context.findAncestorStateOfType<NovelUploadFormState>();
    return RoundedShortTextFieldContainer(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20,0,10,0),
          child: TextFormField(
            onChanged: (text) {
              form?.price = text;
            },
            decoration: const InputDecoration(
                border: InputBorder.none
            ),
          ),
        ));
  }
}
