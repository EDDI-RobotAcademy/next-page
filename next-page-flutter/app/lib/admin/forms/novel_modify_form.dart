import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_bottom_appbar.dart';
import '../api/spring_admin_api.dart';
import '../api/upload_requests.dart';
import '../widgets/novel_author_text_field.dart';
import '../widgets/novel_intro_text_field.dart';
import '../widgets/novel_price_text_field.dart';
import '../widgets/novel_publisher_text_field.dart';
import '../widgets/novel_title_text_field.dart';
import 'package:image_picker/image_picker.dart';

class NovelModifyForm extends StatefulWidget {
  final dynamic novel;

  const NovelModifyForm({Key? key, this.novel}) : super(key: key);

  @override
  State<NovelModifyForm> createState() => NovelModifyFormState();
}

class NovelModifyFormState extends State<NovelModifyForm> {
  final picker = ImagePicker();
  XFile? _image;
  String _category = "판타지";
  String _openToPublicTxt = '공개';
  bool _openToPublic = true;
  String author = '';
  String intro = '';
  String price = '';
  String publisher = '';
  String title = '';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _openToPublic = widget.novel.openToPublic;
    _category = widget.novel.category;
    title = widget.novel.title;
    price = widget.novel.purchasePoint.toString();
    author = widget.novel.author;
    publisher = widget.novel.publisher;
    intro = widget.novel.introduction.replaceAll('<br>', '''
    
    ''');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final openToPublicActionSheet = _openToPublicOverlay();
    final categoryActionSheet = _categoryOverlay();
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width * 0.6,
                child: InkWell(
                  onTap: () {
                    getImage(ImageSource.gallery);
                  },
                  child: _image != null
                      ? Image.file(
                    File(_image!.path),
                    fit: BoxFit.fill,
                  )
                      : Image.asset(
                      'assets/images/thumbnail/${widget.novel.thumbnail}'),
                )),
            Center(),
            SizedBox(
              height: size.height * 0.04,
            ),
            Row(
              children: [
                SizedBox(
                  width: size.width * 0.18,
                ),
                _showOpenToPublicOverlay(openToPublicActionSheet),
                _showCategoryOverlay(categoryActionSheet),
              ],
            ),
            _titleText(size, '제목'),
            NovelTitleTextField(
              titleText: title,
            ),
            _customDividedSpace(size),
            Row(
              children: [
                SizedBox(
                  width: size.width * 0.16,
                ),
                Text('회차당 구매 가격'),
                SizedBox(
                  width: size.width * 0.13,
                ),
                NovelPriceTextField(
                  priceText: price.toString(),
                ),
                SizedBox(
                  width: size.width * 0.02,
                ),
                Text('포인트'),
              ],
            ),
            _customDividedSpace(size),
            _titleText(size, '작가명'),
            NovelAuthorTextField(
              authorText: author,
            ),
            _customDividedSpace(size),
            _titleText(size, '출판사'),
            NovelPublisherTextField(
              publisherText: publisher,
            ),
            _customDividedSpace(size),
            _titleText(size, '작품소개'),
            NovelIntroTextField(
              introText: intro,
            ),
            SizedBox(
              height: size.height * 0.08,
            ),
            Container(
                height: size.height * 0.05,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: TextButton(
                    onPressed: () async {
                      print(/*'썸네일: ${_image!.path},*/
                          '공개여부: $_openToPublic, 장르: $_category,  제목: $title,  가격: $price,  작가명: $author, 출판사명: $publisher, 작품소개: $intro');
                      _formKey.currentState?.save();
                      bool priceValid = RegExp(r"^[0-9]*$").hasMatch(price);
                      _image == null &&
                          title == widget.novel.title &&
                          price == widget.novel.purchasePoint.toString() &&
                          author == widget.novel.author &&
                          publisher == widget.novel.publisher &&
                          intro == widget.novel.introduction &&
                          _openToPublic ==  widget.novel.openToPublic &&
                          _category == widget.novel.category
                          ? _showResultDialog(
                          title: '변경 사항 없음', content: '변경 사항을 작성해주세요')
                          : title == ''
                          ? _showResultDialog(
                          title: "등록 실패", content: "소설의 제목을 입력해주세요.")
                          : price == ''
                          ? _showResultDialog(
                          title: "등록 실패",
                          content: "회차당 구매가격을 입력해주세요.")
                          : priceValid == false
                          ? _showResultDialog(
                          title: "등록 실패",
                          content: "구매가격애는 숫자만 입력 가능합니다.")
                          : author == ''
                          ? _showResultDialog(
                          title: "등록 실패",
                          content: "작가명을 입력해주세요.")
                          : publisher == ''
                          ? _showResultDialog(
                          title: "등록 실패",
                          content: "출판사명을 입력해주세요.")
                          : intro == ''
                          ? _showResultDialog(
                          title: "등록 실패",
                          content: "작품 소개를 입력해주세요.")
                          : _image == null
                          ? await SpringAdminApi()
                          .modifyNovelInformationWithoutImage(
                          widget.novel.id,
                          NovelModifyRequest(
                              title,
                              _category,
                              _openToPublic,
                              author,
                              int.parse(
                                  price),
                              publisher,
                              intro))
                          .then((value) {
                        value
                            ? _showResultDialog(
                            title:
                            '수정 성공',
                            content:
                            '소설 정보 수정에 성공했습니다.')
                            : _showResultDialog(
                            title:
                            '수정 실패',
                            content:
                            '통신 상태를 확인해주세요.');
                      })
                          : await SpringAdminApi()
                          .modifyNovelInformationWithImage(
                          _image!,
                          widget.novel.id,
                          NovelModifyRequest(
                              title,
                              _category,
                              _openToPublic,
                              author,
                              int.parse(
                                  price),
                              publisher,
                              intro))
                          .then((value) {
                        value
                            ? _showResultDialog(
                            title:
                            '수정 성공',
                            content:
                            '소설 정보 수정에 성공했습니다.')
                            : _showResultDialog(
                            title:
                            '수정 실패',
                            content:
                            '통신 상태를 확인해주세요.');
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        '수정하기',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ))),
            SizedBox(
              height: size.height * 0.04,
            ),
          ],
        ),
      ),
    );
  }

  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    setState(() {
      _image = image; // 가져온 이미지를 _image에 저장
    });
  }

  //카테고리 드롭다운 구성
  Widget _categoryOverlay() {
    return CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            setState(() {
              _category = "판타지";
            });
            Navigator.pop(context);
            print(_category);
          },
          child: const Text("판타지"),
        ),
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            setState(() {
              _category = "무협";
            });
            Navigator.pop(context);
            print(_category);
          },
          child: const Text("무협"),
        ),
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            setState(() {
              _category = "로맨스";
            });
            Navigator.pop(context);
            print(_category);
          },
          child: const Text("로맨스"),
        ),
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            setState(() {
              _category = "현판";
            });
            Navigator.pop(context);
            print(_category);
          },
          child: const Text("현대판타지"),
        ),
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            setState(() {
              _category = "BL";
            });
            Navigator.pop(context);
            print(_category);
          },
          child: const Text("BL"),
        ),
      ],
    );
  }

  //카테고리 드롭다운 열기
  Widget _showCategoryOverlay(dynamic categoryActionSheet) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            '장르',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        Wrap(children: [
          ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                elevation: MaterialStateProperty.all(0.0),
              ),
              child: Row(
                children: [
                  Text(
                    _category,
                    style: TextStyle(color: Colors.black),
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                ],
              ),
              onPressed: () {
                showCupertinoModalPopup(
                    context: context,
                    builder: (context) => categoryActionSheet);
              })
        ]),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.05,
        ),
      ],
    );
  }

  //공개여부 드롭다운 구성
  Widget _openToPublicOverlay() {
    return CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            setState(() {
              _openToPublic = true;
              _openToPublicTxt = '공개';
            });
            Navigator.pop(context);
            print(_openToPublic);
          },
          child: const Text("공개"),
        ),
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            setState(() {
              _openToPublic = false;
              _openToPublicTxt = '비공개';
            });
            Navigator.pop(context);
            print(_openToPublic);
          },
          child: const Text("비공개"),
        ),
      ],
    );
  }

  //공개여부 드롭다운 열기
  Widget _showOpenToPublicOverlay(dynamic openToPublicActionSheet) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            '공개여부',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        Wrap(children: [
          ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                elevation: MaterialStateProperty.all(0.0),
              ),
              child: Row(
                children: [
                  Text(
                    _openToPublicTxt,
                    style: const TextStyle(color: Colors.black),
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                ],
              ),
              onPressed: () {
                showCupertinoModalPopup(
                    context: context,
                    builder: (context) => openToPublicActionSheet);
              })
        ]),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.05,
        ),
      ],
    );
  }

  Widget _customDividedSpace(Size size) {
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.02,
        ),
        Container(
            width: size.width * 0.8,
            child: const Divider(
              thickness: 2,
            )),
        SizedBox(
          height: size.height * 0.02,
        ),
      ],
    );
  }

  void _showResultDialog({String? title, String? content}) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title!),
            content: Text(content!),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text("확인"),
                onPressed: () {
                  (title.contains('성공'))
                      ? Get.offAll(const CustomBottomAppbar(routeIndex: 0))
                      : Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  Widget _titleText(Size size, String txt) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: size.width * 0.15,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: size.height * 0.005),
          child: Text(
            txt,
            style: TextStyle(
                fontSize: size.width * 0.05, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
