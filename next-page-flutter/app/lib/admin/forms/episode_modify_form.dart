import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../utility/page_navigate.dart';
import '../../utility/providers/episode_provider.dart';
import '../api/spring_admin_api.dart';
import '../api/upload_requests.dart';
import '../widgets/episode_content_text_field.dart';
import '../widgets/episode_title_text_field.dart';
import '../widgets/novel_price_text_field.dart';

class EpisodeModifyForm extends StatefulWidget {
  final dynamic episode;

  const EpisodeModifyForm({
    Key? key,
    this.episode,
  }) : super(key: key);

  @override
  State<EpisodeModifyForm> createState() => EpisodeModifyFormState();
}

class EpisodeModifyFormState extends State<EpisodeModifyForm> {
  EpisodeProvider? _episodeProvider;
  String _charged = '유료';
  bool _isFree = true;
  String episodeTitle = '';
  String episodeNumber = '';
  String content = '';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _episodeProvider = Provider.of<EpisodeProvider>(context, listen: false);
    episodeTitle = widget.episode['episodeTitle'];
    content = widget.episode['text'];
    episodeNumber = widget.episode['episodeNumber'].toString();
    _isFree = widget.episode['needToBuy'];
    _isFree ? _charged = '유료' : _charged = '무료';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final openFreeOrNotActionSheet = _openFreeOrNotOverlay();
    Size _size = MediaQuery
        .of(context)
        .size;
    return SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: _size.height * 0.04,
              ),
              EpisodeTitleTextField(titleText: episodeTitle),
              _customDividedSpace(_size),
              Row(
                children: [
                  SizedBox(
                    width: _size.width * 0.1,
                  ),
                  _showOpenFreeOrNotOverlay(openFreeOrNotActionSheet),
                  SizedBox(
                    width: _size.width * 0.001,
                  ),
                  Text('에피소드'),
                  SizedBox(
                    width: _size.width * 0.02,
                  ),
                  NovelPriceTextField(
                    priceText: episodeNumber,
                  ),
                  SizedBox(
                    width: _size.width * 0.02,
                  ),
                  Text('화'),
                ],
              ),
              _customDividedSpace(_size),
              EpisodeContentTextField(content: content),
              SizedBox(
                height: _size.height * 0.03,
              ),
              Container(
                height: _size.height * 0.05,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: TextButton(
                  onPressed: () {
                    _formKey.currentState?.save();
                    print(
                        '에피소드: $episodeTitle, 구매필요여부: $_isFree,  에피소드: $episodeNumber화,  본문: $content');
                    print(
                        '기존 에피소드: ${widget
                            .episode['episodeTitle']}, 기존 구매필요여부: ${widget
                            .episode['needToBuy']},  기존 에피소드: ${widget
                            .episode['episodeNumber']}화,  기존 본문: ${widget
                            .episode['text']}');
                    bool episodeNumberValid = RegExp(r"^[0-9]*$").hasMatch(
                        episodeNumber);
                    episodeTitle == widget.episode['episodeTitle'] &&
                        content == widget.episode['text'] &&
                        episodeNumber ==
                            widget.episode['episodeNumber'].toString() &&
                        _isFree == widget.episode['needToBuy']
                        ? _showResultDialog(
                        title: '수정 실패', content: '변경사항이 없습니다.')
                        : episodeTitle == ''
                        ? _showResultDialog(
                        title: "등록 실패", content: "에피소드 제목을 입력해주세요.")
                        : episodeNumber == ''
                        ? _showResultDialog(
                        title: "등록 실패", content: "에피소드 회차를 입력해주세요.")
                        : episodeNumberValid == false
                        ? _showResultDialog(
                        title: "등록 실패",
                        content: "회차에는 숫자만 입력 가능합니다.")
                        : content == ''
                        ? _showResultDialog(
                        title: "등록 실패",
                        content: "에피소드 본문을 입력해주세요.")
                        : SpringAdminApi().modifyEpisode(EpisodeModifyRequest(
                        int.parse(episodeNumber), episodeTitle, content, _isFree,
                        widget.episode['id'])).then((value){
                          value?
                              _showResultDialog(title: "수정 성공", content: "에피소드 수정에 성공했습니다.")
                      :_showResultDialog(title: "수정 실패", content: "통신 상태를 확인해주세요.");
                    });
                  },
                  child: Text(
                    '에피소드 등록',
                    style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: _size.height * 0.15,
              )
            ],
          ),
        ));
  }

  Widget _openFreeOrNotOverlay() {
    return CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            setState(() {
              _isFree = true;
              _charged = '유료';
            });
            Navigator.pop(context);
            print(_isFree);
          },
          child: const Text("유료"),
        ),
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            setState(() {
              _isFree = false;
              _charged = '무료';
            });
            Navigator.pop(context);
            print(_isFree);
          },
          child: const Text("무료"),
        ),
      ],
    );
  }

  //공개여부 드롭다운 열기
  Widget _showOpenFreeOrNotOverlay(dynamic openFreeOrNotActionSheet) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            '구매 필요 여부',
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
                    _charged,
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
                    builder: (context) => openFreeOrNotActionSheet);
              })
        ]),
        SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width * 0.05,
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
                  (title.contains('성공')) ? popPopPop() : Get.back();
                },
              )
            ],
          );
        });
  }
}
