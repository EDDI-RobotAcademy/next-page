import 'package:flutter/material.dart';
import '../../widgets/custom_title_appbar.dart';
import '../forms/novel_modify_form.dart';


class NovelManagementScreen extends StatelessWidget {

  final dynamic novel;

  const NovelManagementScreen({Key? key, required this.novel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customTitleAppbar(context, '소설 관리', 99),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NovelModifyForm(novel: novel)
          ],
        ),
      )
    );
  }
}
