import 'package:flutter/material.dart';
import '../../app_theme.dart';
import '../../comment/comment_list_screen.dart';
import '../../model/tmp_novel_model.dart';
import 'novel_detail_screen.dart';
import '../widgets/sliding_appbar.dart';

class ScrollNovelViewerScreen extends StatefulWidget {
  final String appBarTitle;
  final int episode;
  final int id;

  const ScrollNovelViewerScreen(
      {Key? key, required this.appBarTitle, required this.episode, required this.id})
      : super(key: key);

  @override
  State<ScrollNovelViewerScreen> createState() =>
      _ScrollNovelViewerScreenState();
}

//애니메이션 사용을 위해 클래스 선언시 추가해야 하는 부분
class _ScrollNovelViewerScreenState extends State<ScrollNovelViewerScreen>
    with SingleTickerProviderStateMixin {
  double _cdx = 0;

  double get cdx => _cdx;

  late final AnimationController _animationController;
  final ScrollController _scrollController = ScrollController();
  bool visible = true;

  @override
  void initState() {
    Future.microtask(() {
      _cdx = MediaQuery.of(context).size.width / 2;
    }).then((value) => setState(() {
      print(_cdx);
    }));
    super.initState();
    //애니메이션 사용을 위해서는 initState에서 초기설정 필요
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _scrollController.addListener(() {
      _scrollListener();
      print('offset = ${_scrollController.offset}');
    });
  }

  _scrollListener() async {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      print('스크롤이 맨 바닥에 위치해 있습니다');
    } else if (_scrollController.offset ==
        _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      print('스크롤이 맨 위에 위치해 있습니다');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //클릭 위치에 따라 슬라이드하며 보였다 사라지는 반응형 앱바
        appBar: SlidingAppBar(
            controller: _animationController,
            visible: visible,
            //반응형 앱바의 구성
            child: _buildViewerAppbar()),
        //뷰어의 텍스트가 상단앱바에 가려지지 않도록
        extendBodyBehindAppBar: true,
        //뷰어의 소설 텍스트본문
        body: _buildViewerBody(),
        //반응형 바텀앱바
        bottomNavigationBar: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            height: visible ? size.height * 0.1 : 0.0,
            child: _buildViewerBottomAppbar()));
  }

  AppBar _buildViewerAppbar() {
    return AppBar(
      backgroundColor: (visible) ? AppTheme.viewerAppbar : Colors.transparent,
      elevation: 0.0,
      title: Text(
        '${widget.appBarTitle} ${widget.episode}화',
        style: const TextStyle(color: Colors.black),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => NovelDetailScreen(id: widget.id,routeIndex: 99,)),
                  (route) => false);
        },
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings_outlined,
              color: Colors.black,
            ))
      ],
    );
  }

  Widget _buildViewerBody() {
    return GestureDetector(
      onTapDown: (TapDownDetails td) {
        setState(() {
          if (visible) {
            visible = false;
          } else {
            visible = true;
          }
        });
      },
      child: Scrollbar(
        controller: _scrollController,
        child: ListView(
          controller: _scrollController,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text(
                    TmpNovelModel.novelList[0].content,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.4),
                Container(
                  child: Text('작품 정보라던지?'),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              ],
            )
          ],
        ),
      ),
    );
  }

  BottomAppBar _buildViewerBottomAppbar() {
    return BottomAppBar(
        color: AppTheme.viewerAppbar,
        child: visible
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                style: ButtonStyle(
                    foregroundColor:
                    MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  _scrollController
                      .jumpTo(_scrollController.position.minScrollExtent);
                },
                icon: const Icon(
                  Icons.keyboard_arrow_up,
                  size: 20,
                ),
                label: const Text("처음으로")),
            TextButton.icon(
                style: ButtonStyle(
                    foregroundColor:
                    MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  _scrollController
                      .jumpTo(_scrollController.position.maxScrollExtent);
                },
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  size: 20,
                ),
                label: const Text("맨끝으로")),
            TextButton.icon(
                style: ButtonStyle(
                    foregroundColor:
                    MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CommentListScreen(
                          id: widget.id,
                          appBarTitle:
                          TmpNovelModel.novelList[0].title,
                          fromWhere: widget.episode,
                        )),
                  );
                },
                icon: const Icon(
                  Icons.sms_outlined,
                  size: 20,
                ),
                label: const Text("23")),
            TextButton.icon(
                style: ButtonStyle(
                    foregroundColor:
                    MaterialStateProperty.all(Colors.black)),
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back,
                  size: 20,
                ),
                label: const Text("이전")),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextButton.icon(
                  style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all(Colors.black)),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 20,
                  ),
                  label: const Text("다음")),
            ),
          ],
        )
            : Container());
  }
}
