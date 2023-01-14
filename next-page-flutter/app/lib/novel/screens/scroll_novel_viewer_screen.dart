import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_theme.dart';
import '../../comment/comment_list_screen.dart';
import '../../utility/providers/comment_provider.dart';
import 'novel_detail_screen.dart';
import '../widgets/sliding_appbar.dart';

class ScrollNovelViewerScreen extends StatefulWidget {
  final String appBarTitle;
  final int id;
  final int routeIndex;
  final String text;
  final String episodeTitle;
  final String author;
  final dynamic episodeInfo;
  final String publisher;
  final int purchasePoint;

  const ScrollNovelViewerScreen(
      {Key? key,
      required this.appBarTitle,
      required this.id,
      required this.routeIndex,
      required this.text,
      required this.episodeTitle,
      required this.author,
      required this.episodeInfo,
      required this.publisher,
      required this.purchasePoint})
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
    // 해당 에피소드의 댓글 정보 불러오기
    Provider.of<CommentProvider>(context, listen: false).requestEpisodeCommentList(widget.episodeInfo['id']);
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
            child: _buildViewerBottomAppbar(context.watch<CommentProvider>().commentCount)));
  }

  AppBar _buildViewerAppbar() {
    return AppBar(
      backgroundColor: (visible) ? AppTheme.viewerAppbar : Colors.transparent,
      elevation: 0.0,
      title: Text(
        '${widget.appBarTitle} ${widget.episodeInfo['episodeNumber']}화',
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
                  builder: (BuildContext context) => NovelDetailScreen(
                        id: widget.id,
                        routeIndex: widget.routeIndex,
                      )),
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

  Widget _customSizedBox(){
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height *0.05,
    );
  }

  Widget _buildViewerBody() {
    Size size = MediaQuery.of(context).size;
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  /*
                  * 소설 에피소드의 제목
                  * */
                  child: Text(
                    widget.episodeTitle,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.08,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Padding(
                  padding: EdgeInsets.fromLTRB(size.width * 0.03, 10, size.width * 0.03, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*
                       * 에피소드의 본문 내용
                       * */
                      Text(
                        widget.text,
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width * 0.045),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(size.width * 0.06, 10, size.width * 0.06, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.appBarTitle, style: TextStyle(
                        fontSize: size.width * 0.045
                      ),),
                      _customSizedBox(),
                      Text('${widget.episodeInfo['episodeNumber']}화', style: TextStyle(
                          fontSize: size.width * 0.045
                      ),),
                      _customSizedBox(),
                      Text('지은이 : ${widget.author}', style: TextStyle(
                          fontSize: size.width * 0.045
                      ),),
                      _customSizedBox(),
                      Text('출판사 : ${widget.publisher}', style: TextStyle(
                          fontSize: size.width * 0.045
                      ),),
                      _customSizedBox(),
                      Text('업로드일 : ${widget.episodeInfo['uploadedDate']}', style: TextStyle(
                          fontSize: size.width * 0.045
                      ),),
                      _customSizedBox(),
                      Text('정가 : ${widget.purchasePoint}원', style: TextStyle(
                          fontSize: size.width * 0.045
                      ),),
                      _customSizedBox(),
                      Text('제공 : NEXT PAGE', style: TextStyle(
                          fontSize: size.width * 0.045
                      ),),
                      _customSizedBox(),
                      _customSizedBox(),
                      Text(''' 이 책은 NEXT PAGE가 저작권자와의 계약에 따라 전자책으로 발행한 것입니다.
본사의 허락없이 본서의 내용을 무단복제 하는 것은 저작권법에 의해 금지되어 있습니다.''', style: TextStyle(
                          fontSize: size.width * 0.045
                      ),),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              ],
            )
          ],
        ),
      ),
    );
  }

  BottomAppBar _buildViewerBottomAppbar(int commentCount) {
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
                                    appBarTitle: widget.appBarTitle,
                                    fromWhere:
                                        widget.episodeInfo['episodeNumber'],
                                    routeIndex: widget.routeIndex,
                                  )),
                        );
                      },
                      icon: const Icon(
                        Icons.sms_outlined,
                        size: 20,
                      ),
                      label: Text(commentCount.toString())),
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
