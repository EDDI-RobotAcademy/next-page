import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app_theme.dart';
import '../../comment/comment_list_screen.dart';
import '../../utility/providers/comment_provider.dart';
import '../../utility/providers/episode_provider.dart';
import '../api/novel_requests.dart';
import '../api/spring_novel_api.dart';
import '../widgets/custom_purchase_dialog.dart';
import 'novel_detail_screen.dart';
import '../widgets/sliding_appbar.dart';

class ScrollNovelViewerScreen extends StatefulWidget {
  final String appBarTitle;
  final int id; // novel info id
  final int routeIndex;
  final String text;
  final String episodeTitle;
  final String author;
  final dynamic episodeInfo;
  final String publisher;
  final int purchasePoint;
  final List<dynamic> purchasedEpisodeList;

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
        required this.purchasePoint,
        required this.purchasedEpisodeList})
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
  EpisodeProvider? _episodeProvider;
  late int? _lastEpisodeNo;
  late int _presentEpisodeNo;
  late int _currentPoint;
  late int _memberId;
  late String _nickname;
  bool _isPurchased = false;

  @override
  void initState() {
    _asyncMethod();
    // 해당 에피소드의 댓글 정보 불러오기
    Provider.of<CommentProvider>(context, listen: false)
        .requestEpisodeCommentList(widget.episodeInfo['id']);
    _episodeProvider = Provider.of<EpisodeProvider>(context, listen: false);
    _episodeMethod();
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

  void _episodeMethod() {
    setState(() {
      _lastEpisodeNo = _episodeProvider!.episodesLength;
      _presentEpisodeNo = widget.episodeInfo['episodeNumber'];
    });
    print('마지막화는? $_lastEpisodeNo');
  }

  void _asyncMethod() async {
    var prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');
    if (userToken != null) {
      setState(() {
        _currentPoint = prefs.getInt('point')!;
        _memberId = prefs.getInt('userId')!;
        _nickname = prefs.getString('nickname')!;
      });
    }
    _nickname != 'admin'
        ? SpringNovelApi().requestViewCountUp(widget.id)
        : print('관리자로 에피소드 감상 시 조회수가 오르지 않습니다.');
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
            child: _buildViewerBottomAppbar(
                context.watch<CommentProvider>().commentCount)));
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

  Widget _customSizedBox() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.05,
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
                  padding: EdgeInsets.fromLTRB(
                      size.width * 0.03, 10, size.width * 0.03, 0),
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
                  padding: EdgeInsets.fromLTRB(
                      size.width * 0.06, 10, size.width * 0.06, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.appBarTitle,
                        style: TextStyle(fontSize: size.width * 0.045),
                      ),
                      _customSizedBox(),
                      Text(
                        '${widget.episodeInfo['episodeNumber']}화',
                        style: TextStyle(fontSize: size.width * 0.045),
                      ),
                      _customSizedBox(),
                      Text(
                        '지은이 : ${widget.author}',
                        style: TextStyle(fontSize: size.width * 0.045),
                      ),
                      _customSizedBox(),
                      Text(
                        '출판사 : ${widget.publisher}',
                        style: TextStyle(fontSize: size.width * 0.045),
                      ),
                      _customSizedBox(),
                      Text(
                        '업로드일 : ${widget.episodeInfo['uploadedDate']}',
                        style: TextStyle(fontSize: size.width * 0.045),
                      ),
                      _customSizedBox(),
                      Text(
                        '정가 : ${widget.purchasePoint}원',
                        style: TextStyle(fontSize: size.width * 0.045),
                      ),
                      _customSizedBox(),
                      Text(
                        '제공 : NEXT PAGE',
                        style: TextStyle(fontSize: size.width * 0.045),
                      ),
                      _customSizedBox(),
                      _customSizedBox(),
                      Text(
                        ''' 이 책은 NEXT PAGE가 저작권자와의 계약에 따라 전자책으로 발행한 것입니다.
본사의 허락없이 본서의 내용을 무단복제 하는 것은 저작권법에 의해 금지되어 있습니다.''',
                        style: TextStyle(fontSize: size.width * 0.045),
                      ),
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
                          episodeId: widget.episodeInfo['id'],
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
                onPressed: () {
                  print('현재는 몇화: $_presentEpisodeNo');
                  print('내 닉네임은?: $_nickname');
                  _presentEpisodeNo != 1
                      ? _checkPurchasedEpisode(_episodeProvider!
                      .episodeList[_presentEpisodeNo! - 2])
                      : print('1화당');
                  widget.episodeInfo['episodeNumber'] != 1
                      ? (_episodeProvider!
                      .episodeList[_presentEpisodeNo! - 2]
                  ['needToBuy'])
                      ? _nickname == 'admin'
                      ? Get.offAll(() => ScrollNovelViewerScreen(
                    appBarTitle: widget.appBarTitle,
                    id: widget.id,
                    routeIndex: widget.routeIndex,
                    text: _episodeProvider!.episodeList[
                    _presentEpisodeNo! - 2]['text'],
                    episodeTitle:
                    _episodeProvider!.episodeList[
                    _presentEpisodeNo! - 2]
                    ['episodeTitle'],
                    author: widget.author,
                    episodeInfo:
                    _episodeProvider!.episodeList[
                    _presentEpisodeNo! - 2],
                    publisher: widget.publisher,
                    purchasePoint: widget.purchasePoint,
                    purchasedEpisodeList:
                    widget.purchasedEpisodeList,
                  ))
                      : SpringNovelApi()
                      .checkPurchaseEpisode(
                      CheckPurchasedEpisodeRequest(
                          _episodeProvider!.episodeList[
                          _presentEpisodeNo! - 2]
                          ['id'],
                          _memberId))
                      .then((value) {
                    print('이전화 구입했니? $value');
                    value
                        ? Get.offAll(() =>
                        ScrollNovelViewerScreen(
                          appBarTitle:
                          widget.appBarTitle,
                          id: widget.id,
                          routeIndex: widget.routeIndex,
                          text: _episodeProvider!
                              .episodeList[
                          _presentEpisodeNo! -
                              2]['text'],
                          episodeTitle: _episodeProvider!
                              .episodeList[
                          _presentEpisodeNo! -
                              2]['episodeTitle'],
                          author: widget.author,
                          episodeInfo: _episodeProvider!
                              .episodeList[
                          _presentEpisodeNo! - 2],
                          publisher: widget.publisher,
                          purchasePoint:
                          widget.purchasePoint,
                          purchasedEpisodeList: widget
                              .purchasedEpisodeList,
                        ))
                        : _showAlertDialog(
                        context,
                        CustomPurchaseDialog(
                          routeIndex: widget.routeIndex,
                          memberId: _memberId,
                          novelId: widget.id,
                          novelTitle:
                          widget.appBarTitle,
                          purchasePoint:
                          widget.purchasePoint,
                          point: _currentPoint,
                          episode: _episodeProvider!
                              .episodeList[
                          _presentEpisodeNo! - 2],
                          author: widget.author,
                          publisher: widget.publisher,
                          purchasedEpisodeList: widget
                              .purchasedEpisodeList,
                        ));
                  })
                      : Get.offAll(() => ScrollNovelViewerScreen(
                    appBarTitle: widget.appBarTitle,
                    id: widget.id,
                    routeIndex: widget.routeIndex,
                    text: _episodeProvider!.episodeList[
                    _presentEpisodeNo! - 2]['text'],
                    episodeTitle:
                    _episodeProvider!.episodeList[
                    _presentEpisodeNo! - 2]
                    ['episodeTitle'],
                    author: widget.author,
                    episodeInfo: _episodeProvider!
                        .episodeList[_presentEpisodeNo! - 2],
                    publisher: widget.publisher,
                    purchasePoint: widget.purchasePoint,
                    purchasedEpisodeList:
                    widget.purchasedEpisodeList,
                  ))
                      : _failResult('첫 화입니다.');
                },
                icon: Icon(Icons.arrow_back,
                    size: 20,
                    color: widget.episodeInfo['episodeNumber'] == 1
                        ? Colors.grey
                        : Colors.black),
                label: Text(
                  "이전",
                  style: TextStyle(
                      color: widget.episodeInfo['episodeNumber'] == 1
                          ? Colors.grey
                          : Colors.black),
                )),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextButton.icon(
                  style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all(Colors.black)),
                  onPressed: () {
                    print('현재는 몇화: $_presentEpisodeNo');
                    print('내 닉네임은?: $_nickname');
                    widget.episodeInfo['episodeNumber'] != _lastEpisodeNo!
                        ? _checkPurchasedEpisode(_episodeProvider!
                        .episodeList[_presentEpisodeNo!])
                        : print('마지막 화당');
                    widget.episodeInfo['episodeNumber'] != _lastEpisodeNo!
                        ? (_episodeProvider!
                        .episodeList[_presentEpisodeNo!]
                    ['needToBuy'])
                        ? _nickname == 'admin'
                        ? Get.offAll(() =>
                        ScrollNovelViewerScreen(
                          appBarTitle: widget.appBarTitle,
                          id: widget.id,
                          routeIndex: widget.routeIndex,
                          text: _episodeProvider!.episodeList[
                          _presentEpisodeNo!]['text'],
                          episodeTitle:
                          _episodeProvider!.episodeList[
                          _presentEpisodeNo!]
                          ['episodeTitle'],
                          author: widget.author,
                          episodeInfo:
                          _episodeProvider!.episodeList[
                          _presentEpisodeNo!],
                          publisher: widget.publisher,
                          purchasePoint: widget.purchasePoint,
                          purchasedEpisodeList:
                          widget.purchasedEpisodeList,
                        ))
                        : SpringNovelApi()
                        .checkPurchaseEpisode(
                        CheckPurchasedEpisodeRequest(
                            _episodeProvider!.episodeList[
                            _presentEpisodeNo!]['id'],
                            _memberId))
                        .then((value) {
                      print('다음화 구입했니? $value');
                      value
                          ? Get.offAll(() =>
                          ScrollNovelViewerScreen(
                            appBarTitle:
                            widget.appBarTitle,
                            id: widget.id,
                            routeIndex:
                            widget.routeIndex,
                            text: _episodeProvider!
                                .episodeList[
                            _presentEpisodeNo!]
                            ['text'],
                            episodeTitle: _episodeProvider!
                                .episodeList[
                            _presentEpisodeNo!]
                            ['episodeTitle'],
                            author: widget.author,
                            episodeInfo:
                            _episodeProvider!
                                .episodeList[
                            _presentEpisodeNo!],
                            publisher: widget.publisher,
                            purchasePoint:
                            widget.purchasePoint,
                            purchasedEpisodeList: widget
                                .purchasedEpisodeList,
                          ))
                          : _showAlertDialog(
                          context,
                          CustomPurchaseDialog(
                            routeIndex:
                            widget.routeIndex,
                            memberId: _memberId,
                            novelId: widget.id,
                            novelTitle:
                            widget.appBarTitle,
                            purchasePoint:
                            widget.purchasePoint,
                            point: _currentPoint,
                            episode: _episodeProvider!
                                .episodeList[
                            _presentEpisodeNo!],
                            author: widget.author,
                            publisher: widget.publisher,
                            purchasedEpisodeList: widget
                                .purchasedEpisodeList,
                          ));
                    })
                        : Get.offAll(() => ScrollNovelViewerScreen(
                      appBarTitle: widget.appBarTitle,
                      id: widget.id,
                      routeIndex: widget.routeIndex,
                      text: _episodeProvider!
                          .episodeList[_presentEpisodeNo!]
                      ['text'],
                      episodeTitle: _episodeProvider!
                          .episodeList[_presentEpisodeNo!]
                      ['episodeTitle'],
                      author: widget.author,
                      episodeInfo: _episodeProvider!
                          .episodeList[_presentEpisodeNo!],
                      publisher: widget.publisher,
                      purchasePoint: widget.purchasePoint,
                      purchasedEpisodeList:
                      widget.purchasedEpisodeList,
                    ))
                        : _failResult('마지막 화입니다.');
                  },
                  icon: Icon(Icons.arrow_back,
                      size: 20,
                      color: _lastEpisodeNo ==
                          widget.episodeInfo['episodeNumber']
                          ? Colors.grey
                          : Colors.black),
                  label: Text(
                    "다음",
                    style: TextStyle(
                        color: _lastEpisodeNo ==
                            widget.episodeInfo['episodeNumber']
                            ? Colors.grey
                            : Colors.black),
                  )),
            ),
          ],
        )
            : Container());
  }

  void _failResult(String toastMsg) {
    Fluttertoast.showToast(
        msg: toastMsg,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1);
  }

  void _checkPurchasedEpisode(dynamic episode) {
    for (int i = 0; i < widget.purchasedEpisodeList.length; i++) {
      _isPurchased = false;
      if (widget.purchasedEpisodeList[i].episodeId == episode['id']) {
        _isPurchased = true;
        break;
      }
    }
  }

  void _showAlertDialog(BuildContext context, Widget alert) {
    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}
