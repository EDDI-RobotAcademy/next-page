import 'package:app/app_theme.dart';
import 'package:app/mypage/api/requests.dart';
import 'package:app/mypage/api/spring_mypage_api.dart';
import 'package:app/mypage/screens/qna_screen.dart';
import 'package:app/mypage/widgets/board_text_field.dart';
import 'package:app/mypage/widgets/category_drop_down.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../member/widgets/alerts/custom_result_alert.dart';
import '../../utility/page_navigate.dart';
import '../../utility/providers/category_provider.dart';

class QnaRegisterForm extends StatefulWidget {
  const QnaRegisterForm({Key? key, required this.memberId}) : super(key: key);
  final int memberId;

  @override
  State<QnaRegisterForm> createState() => QnaRegisterFormState();
}

class QnaRegisterFormState extends State<QnaRegisterForm> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String content;
  bool registerResult = false;

  List<String> categoryList = <String>['소설 문의', '서비스 문의', '환불/취소 문의', '기타'];

  late TextEditingController titleController = TextEditingController();
  late TextEditingController contentController = TextEditingController();
  late CategoryProvider _categoryProvider;

  @override
  void initState() {
    _categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    titleController.addListener(() {
      title = titleController.text;
    });
    contentController.addListener(() {
      content = contentController.text;
    });
    super.initState();
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
                          showAlertDialog(context,
                              CustomResultAlert(title: '알림', alertMsg: '카테고리를 선택해주세요!'));
                        } else {
                          debugPrint('memberId: ' + widget.memberId.toString());
                          debugPrint('category: ' + qnaCategory);

                          registerResult = await SpringMyPageApi().qnaRegister(
                                                    QnaRegisterRequest(widget.memberId, title, qnaCategory, content));
                          if(registerResult == true) {
                            //provider의 카테고리 값을 비웁니다.
                            _categoryProvider.categoryReset();
                            showAlertDialog(context,
                               AlertDialog(
                                   shape: const RoundedRectangleBorder(
                                       borderRadius: BorderRadius.all(Radius.circular(25.0))),
                                   title: Text('알림'),
                                   content: Text('QnA 등록이 완료되었습니다.'),
                                   actions: <Widget>[
                                     TextButton(
                                         onPressed: () {
                                           popPopPush(context, QnaScreen(memberId: widget.memberId));
                                          },
                                         child: const Text('확인')
                                     )
                                   ]
                               ));
                          } else {
                            showAlertDialog(context,
                                CustomResultAlert(title: '알림', alertMsg: 'QnA 등록에 실패했습니다.\n다시 시도해주세요.'));
                          }
                        }
                      } else {
                        showAlertDialog(context,
                            CustomResultAlert(title: '알림', alertMsg: '제목과 문의내용을 모두 입력해주세요!'));
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

  void showAlertDialog(BuildContext context, Widget alert) {
    showDialog(
        context: context,
        builder: (BuildContext context) => alert);
  }

}