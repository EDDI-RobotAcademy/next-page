import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/custom_title_appbar.dart';
import '../forms/novel_modify_form.dart';


class NovelModifyScreen extends StatelessWidget {

  final dynamic novel;

  const NovelModifyScreen({Key? key, required this.novel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: customTitleAppbar(context, '소설 관리'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              NovelModifyForm(novel: novel)
            ],
          ),
        )
      ),
    );
  }
}
