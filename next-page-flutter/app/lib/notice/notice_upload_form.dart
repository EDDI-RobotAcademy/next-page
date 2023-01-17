
import 'package:app/notice/api/spring_notice_api.dart';
import 'package:app/notice/api/notice_requests.dart';
import 'package:app/novel/screens/novel_detail_screen.dart';
import 'package:app/utility/page_navigate.dart';
import 'package:app/utility/providers/category_provider.dart';
import 'package:app/widgets/cupertino_result_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../app_theme.dart';
import '../mypage/widgets/board_text_field.dart';
import '../mypage/widgets/category_drop_down.dart';
import '../widgets/custom_title_appbar.dart';

class NoticeUploadForm extends StatefulWidget {
  const NoticeUploadForm({ Key? key, required this.novelInfoId }) : super(key: key);
  final int novelInfoId;

  @override
  State<NoticeUploadForm> createState() => _NoticeUploadFormState();
}

class _NoticeUploadFormState extends State<NoticeUploadForm> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String content;
  bool registerResult = false;
  final int commonNoticeId = 0;
  final String commonCategory = "일반";
  final List<String> categoryList = ['일반', '이벤트', '휴재'];

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
      appBar: customTitleAppbar(context,
          widget.novelInfoId == commonNoticeId
          ? "일반 공지 등록하기" : "작품 공지 등록하기", 99),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Visibility(
                    visible: widget.novelInfoId != 0,
                      child: CategoryDropDown(categoryList: categoryList,)),
                  BoardTextField(usage: '제목', maxLines: 1, controller: titleController),
                  SizedBox(height: size.height * 0.02,),
                  BoardTextField(usage: '공지 내용', maxLines: 20, controller: contentController),
                  SizedBox(height: size.height * 0.02,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: AppTheme.pointColor,
                        minimumSize: Size(size.width * 0.4, size.height * 0.05)),
                    onPressed: () async {
                      String noticeCategory;
                      widget.novelInfoId != 0 ?
                         noticeCategory = _categoryProvider.category
                        : noticeCategory = commonCategory;

                      if(_formKey.currentState!.validate()) {
                        if(noticeCategory.isNotEmpty) {
                          var result = await SpringNoticeApi().writeNotice(
                              WriteNoticeRequest(
                                  title: title,
                                  content: content,
                                  noticeCategory: noticeCategory,
                                  novelInfoId: widget.novelInfoId));
                          if(result) {
                            _categoryProvider.categoryReset();
                            showCupertinoDialog(
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: Text('알림'),
                                    content: Text('공지 등록이 완료되었습니다.'),
                                    actions: [
                                      CupertinoDialogAction(
                                        child: Text('확인'),
                                        onPressed: () {
                                          widget.novelInfoId == 0?
                                          popPopPush(context, NoticeUploadForm(novelInfoId: widget.novelInfoId,))
                                          : Get.off(()=> NovelDetailScreen(id: widget.novelInfoId, routeIndex: 0));
                                        },
                                      )
                                    ],
                                  );
                                });
                          } else {
                            cupertinoResultAlert(context, '알림', '통신이 원활하지 않습니다.');
                          }
                        } else {
                          cupertinoResultAlert(context, '알림', '카테고리를 선택해주세요.');
                        }
                      }
                    },
                    child: Text("공지 등록하기"),
                  )
                ],
              ),
            )
          ),
        ),
    );
  }
}
