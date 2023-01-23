import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../app_theme.dart';
import '../../utility/page_navigate.dart';
import '../../utility/providers/episode_provider.dart';
import '../api/spring_admin_api.dart';
import '../api/upload_requests.dart';
import '../widgets/episode_content_text_field.dart';
import '../widgets/episode_title_text_field.dart';
import '../widgets/novel_price_text_field.dart';

class EpisodeUploadForm extends StatefulWidget {
  final String title;
  final String thumbnail;
  final int novelId;

  const EpisodeUploadForm(
      {Key? key,
      required this.title,
      required this.thumbnail,
      required this.novelId})
      : super(key: key);

  @override
  State<EpisodeUploadForm> createState() => EpisodeUploadFormState();
}

class EpisodeUploadFormState extends State<EpisodeUploadForm> {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final openFreeOrNotActionSheet = _openFreeOrNotOverlay();
    Size _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _episodeProvider!.latestEpisode != null
              ? Container(
                  padding: EdgeInsets.only(top: _size.height * 0.02),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(19),
                        bottomLeft: Radius.circular(19)),
                    child: Card(
                      color: AppTheme.chalk,
                      child: InkWell(
                        child: Row(
                          children: <Widget>[
                            //에피소드 리스트 내의 작은 소설 썸네일
                            Container(
                              width: MediaQuery.of(context).size.width * 0.13,
                              height: MediaQuery.of(context).size.height * 0.08,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/thumbnail/${widget.thumbnail}'),
                                      fit: BoxFit.cover)),
                            ),
                            Container(
                              width: _size.width * 0.5,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    //소설 제목과 에피소드 화
                                    Text(
                                      '${widget.title} ${_episodeProvider!.latestEpisode['episodeNumber'].toString()}화',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17),
                                    ),
                                    //에피소드의 업로드 일자
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(_episodeProvider!
                                          .latestEpisode['uploadedDate']),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Center(
                  child: Container(
                      padding: EdgeInsets.only(top: _size.height * 0.03),
                      child: Text('등록된 에피소드가 없습니다.'))),
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
                    '에피소드: $episodeTitle, 구매필요여부: $_isFree,  에피소드: $episodeNumber화,  가격: $content');
                bool episodeNumberValid =
                    RegExp(r"^[0-9]*$").hasMatch(episodeNumber);
                episodeTitle == ''
                    ? _showResultDialog(
                        title: "등록 실패", content: "에피소드 제목을 입력해주세요.")
                    : episodeNumber == ''
                        ? _showResultDialog(
                            title: "등록 실패", content: "에피소드 회차를 입력해주세요.")
                        : episodeNumberValid == false
                            ? _showResultDialog(
                                title: "등록 실패", content: "회차에는 숫자만 입력 가능합니다.")
                            : content == ''
                                ? _showResultDialog(
                                    title: "등록 실패", content: "에피소드 본문을 입력해주세요.")
                                : SpringAdminApi()
                                    .uploadEpisode(EpisodeUploadRequest(
                                        widget.novelId,
                                        int.parse(episodeNumber),
                                        episodeTitle,
                                        content,
                                        _isFree))
                                    .then((value) {
                                    value
                                        ? _showResultDialog(
                                            title: '업로드 성공',
                                            content: '에피소드 등록에 성공했습니다.')
                                        : _showResultDialog(
                                            title: '업로드 실패',
                                            content: '에피소드 등록에 실패했습니다.');
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
                  (title.contains('성공')) ? popPopPop() : Get.back();
                },
              )
            ],
          );
        });
  }
}
