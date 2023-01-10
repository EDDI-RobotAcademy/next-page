import 'package:app/app_theme.dart';
import 'package:app/mypage/api/requests.dart';
import 'package:app/mypage/api/spring_mypage_api.dart';
import 'package:app/mypage/widgets/board_text_field.dart';
import 'package:app/mypage/widgets/category_drop_down.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../member/widgets/alerts/custom_result_alert.dart';
import '../../utility/providers/category_provider.dart';

class QnaRegisterForm extends StatefulWidget {
  const QnaRegisterForm({Key? key}) : super(key: key);

  @override
  State<QnaRegisterForm> createState() => QnaRegisterFormState();
}

class QnaRegisterFormState extends State<QnaRegisterForm> {
  final _formKey = GlobalKey<FormState>();
  late int memberId;
  late String title;
  late String content;
  bool registerResult = false;

  List<String> categoryList = <String>['소설 문의', '서비스 문의', '환불/취소 문의', '기타'];

  late TextEditingController titleController = TextEditingController();
  late TextEditingController contentController = TextEditingController();
  late CategoryProvider _categoryProvider;


  @override
  void initState() {
    _asyncMethod();
    _categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    titleController.addListener(() {
      title = titleController.text;
    });
    contentController.addListener(() {
      content = contentController.text;
    });
    super.initState();
  }

  _asyncMethod() async {
    var prefs = await SharedPreferences.getInstance();
    memberId = prefs.getInt('userId')!;
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CategoryDropDown(categoryList: categoryList,),
                  BoardTextField(usage: '제목', maxLines: 1, controller: titleController),
                  SizedBox(height: size.height * 0.02,),
                  BoardTextField(usage: '문의 내용', maxLines: 20, controller: contentController),
                  SizedBox(height: size.height * 0.02,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: AppTheme.pointColor,
                          minimumSize: Size(size.width * 0.4, size.height * 0.05)),
                    onPressed: () async {
                      var qnaCategory = _categoryProvider.category;
                      if(_formKey.currentState!.validate()) {
                        if(qnaCategory.isEmpty) {
                          showResultDialog(context, '알림', '카테고리를 선택해주세요!');
                        } else {
                          debugPrint('memberId: ' + memberId.toString());
                          debugPrint('category: ' + qnaCategory);

                          registerResult = await SpringMyPageApi().
                          qnaRegister(QnaRegisterRequest(memberId, title, qnaCategory, content));
                          if(registerResult == true) {
                            _categoryProvider.categoryReset();
                            showResultDialog(context, '알림', 'QnA가 등록되었습니다!');
                            clearInput();
                          } else {
                            showResultDialog(context, '알림', 'QnA 등록에 실패했습니다.\n다시 시도해주세요.');
                          }
                        }
                      } else {
                        showResultDialog(context, '알림', '제목과 문의내용을 모두 입력해주세요!');
                      }
                  },
                    child: Text('QnA 등록하기'))
                ],
              ),
            )
        ),
      )
    );
  }

  void clearInput() {
    titleController.clear();
    contentController.clear();
  }

  void showResultDialog(BuildContext context, String title, String alertMsg) {
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            CustomResultAlert(title: title, alertMsg: alertMsg));
  }

}