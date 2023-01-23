import 'package:app/admin/forms/qna_management_form.dart';
import 'package:app/widgets/custom_title_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QnaManagementScreen extends StatefulWidget {
  const QnaManagementScreen({Key? key}) : super(key: key);

  @override
  State<QnaManagementScreen> createState() => _QnaManagementScreenState();
}

class _QnaManagementScreenState extends State<QnaManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customTitleAppbar(context, '고객 QnA 관리'),
      body: Card(
        child: Column(
          children: [
            _menuListTileWithDivide('답변 대기 QnA',
                QnaManagementForm(answered: false,)),
            _menuListTileWithDivide('답변 완료 QnA',
                QnaManagementForm(answered: true,)),
          ],
        ),
      ),
    );
  }

  Widget _menuListTileWithDivide(String menu, Widget screen) {
    return Column(
      children: [
        ListTile(
            contentPadding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
            title: Text(menu),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => screen))),
        const Divider(thickness: 1, height: 1,),
      ],
    );
  }
}
