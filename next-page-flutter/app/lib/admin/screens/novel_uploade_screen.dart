import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/custom_title_appbar.dart';
import '../forms/novel_upload_form.dart';



class NovelUploadScreen extends StatefulWidget {
  const NovelUploadScreen({Key? key}) : super(key: key);

  @override
  State<NovelUploadScreen> createState() => _NovelUploadScreenState();
}

class _NovelUploadScreenState extends State<NovelUploadScreen> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: customTitleAppbar(context, '소설 업로드', 99),
        body: NovelUploadForm()
      ),
    );
  }


}
