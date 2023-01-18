import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

import '../../admin/screens/episode_upload_screen.dart';
import '../../admin/screens/novel_modify_screen.dart';
import '../../comment/comment_list_screen.dart';
import '../../member/screens/sign_in_screen.dart';
import '../../notice/api/notice_requests.dart';
import '../../notice/notice_upload_form.dart';
import '../../utility/providers/episode_provider.dart';
import '../../utility/providers/notice_provider.dart';
import '../../widgets/custom_bottom_appbar.dart';
import '../api/spring_novel_api.dart';
import '../widgets/episode_list.dart';
import '../widgets/novel_introduction.dart';
import '../widgets/novel_notice.dart';
import '../widgets/star_rating_dialog.dart';

class NovelDetailScreen extends StatefulWidget {
  final int id; // novel의 id
  final int routeIndex;

  const NovelDetailScreen(
      {Key? key, required this.id, required this.routeIndex})
      : super(key: key);

  @override
  State<NovelDetailScreen> createState() => _NovelDetailScreenState();
}

class _NovelDetailScreenState extends State<NovelDetailScreen>
    with TickerProviderStateMixin {
  Future<dynamic>? _future;
  dynamic _novel;
  late int toBottomAppBar;

  final ScrollController _scrollController = ScrollController();
  late TabController _controller;
  bool? _isLike = true;

  String _nickname = '';
  int? _memberId;

  final Color _beginColor = Colors.transparent;
  final Color _endColor = Colors.white;

  final Color _beginIconColor = Colors.grey;
  final Color _endIconColor = Colors.black;

  final double _animationSpeed = 130;

  late AnimationController _colorAnimationController;
  late Animation _colorTween, _iconColorTween;
  EpisodeProvider? _episodeProvider;
  late bool _loginState;
  late NoticeProvider _noticeProvider;

  @override
  void initState() {
    _episodeProvider = Provider.of<EpisodeProvider>(context, listen: false);
    _episodeProvider!.requestEpisodeList(0, widget.id);
    _future = getNovelInfo();
    _asyncMethod();
    _controller = TabController(length: 3, vsync: this);
    super.initState();
    _colorAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 0));
    _colorTween = ColorTween(begin: _beginColor, end: _endColor)
        .animate(_colorAnimationController);
    _iconColorTween = ColorTween(begin: _beginIconColor, end: _endIconColor)
        .animate(_colorAnimationController);
    _scrollController.addListener(() {
      print('offset = ${_scrollController.offset}');
    });
    if (widget.routeIndex == 0) {
      toBottomAppBar = 0;
    }
    if (widget.routeIndex == 1) {
      toBottomAppBar = 1;
    }
    if (widget.routeIndex == 2) {
      toBottomAppBar = 2; //검색 페이지 자동완성에서 넘어오는 경우 추가
    }
    // 공지 정보를 불러오기 위한 provider
    _noticeProvider = Provider.of<NoticeProvider>(context, listen: false);
    _noticeProvider.getNoticeList(
        NoticeRequest(novelInfoId: widget.id, page: 0, size: 10));
  }

  void _asyncMethod() async {
    var prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');
    userToken != null
        ? setState(() {
      _loginState = true;
      _nickname = prefs.getString('nickname')!;
      _memberId = prefs.getInt('userId')!;
    })
        : setState(() {
      _loginState = false;
    });
  }

  Future getNovelInfo() async {
    await SpringNovelApi().getNovelInfo(widget.id).then((novel) {
      setState(() {
        _novel = novel;
      });
    });
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _colorAnimationController
          .animateTo(scrollInfo.metrics.pixels / _animationSpeed);
      return true;
    } else if (_scrollController.offset >= 340) {
      _colorAnimationController
          .animateTo(scrollInfo.metrics.pixels / _animationSpeed);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: _future,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Scaffold(
                  body: NotificationListener<ScrollNotification>(
                    onNotification: _scrollListener,
                    child: SizedBox(
                      height: double.infinity,
                      child: Stack(children: [
                        NestedScrollView(
                          scrollDirection: Axis.vertical,
                          controller: _scrollController,
                          headerSliverBuilder: (context, innerBoxIsScrolled) => [
                            SliverToBoxAdapter(
                              child: Column(
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              //흐릿한 썸네일을 배경으로 깐다
                                              image: AssetImage(
                                                  'assets/images/thumbnail/${_novel.thumbnail}'),
                                              fit: BoxFit.cover,
                                            )),
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaX: 10, sigmaY: 10),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  color:
                                                  Colors.white.withOpacity(0.1),
                                                  child: Container(
                                                    child: Column(
                                                      children: <Widget>[
                                                        //흐릿한 썸네일 배경위에 썸네일 이미지
                                                        SizedBox(
                                                          height:
                                                          size.height * 0.05,
                                                        ),
                                                        Container(
                                                          padding: const EdgeInsets
                                                              .fromLTRB(
                                                              0, 45, 0, 10),
                                                          height: 300,
                                                          child: Image.asset(
                                                              'assets/images/thumbnail/${_novel.thumbnail}'),
                                                        ),
                                                        //소설 제목
                                                        Container(
                                                          padding:
                                                          const EdgeInsets.all(
                                                              7),
                                                          child: Text(
                                                            _novel.title,
                                                            style: const TextStyle(
                                                                color: Colors.white,
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                        // 장르 + 작가
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Text(
                                                              _novel.category ==
                                                                  '현판'
                                                                  ? '현대판타지'
                                                                  : _novel.category,
                                                              style:
                                                              const TextStyle(
                                                                color:
                                                                Colors.white60,
                                                                fontWeight:
                                                                FontWeight.bold,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                              size.width * 0.01,
                                                            ),
                                                            const Text(
                                                              '•',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white60),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                              size.width * 0.01,
                                                            ),
                                                            Text(
                                                              _novel.author,
                                                              style:
                                                              const TextStyle(
                                                                color:
                                                                Colors.white60,
                                                                fontWeight:
                                                                FontWeight.bold,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                          child: Container(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              children: [
                                                                SizedBox(
                                                                  width:
                                                                  size.width *
                                                                      0.06,
                                                                ),
                                                                //소설 조회수
                                                                Wrap(
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .remove_red_eye_outlined,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 17,
                                                                    ),
                                                                    Text(
                                                                      _novel
                                                                          .viewCount
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .white),
                                                                    )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                  size.width *
                                                                      0.02,
                                                                ),
                                                                ElevatedButton
                                                                    .icon(
                                                                  style:
                                                                  ButtonStyle(
                                                                    padding: MaterialStateProperty.all(
                                                                        EdgeInsets
                                                                            .zero),
                                                                    backgroundColor:
                                                                    MaterialStateProperty.all(
                                                                        Colors.transparent),
                                                                    elevation:
                                                                    MaterialStateProperty.all(
                                                                        0.0),
                                                                  ),
                                                                  icon: const Icon(
                                                                    Icons.star,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 17,
                                                                  ),
                                                                  label: Text(_novel
                                                                      .starRating
                                                                      .toString(),
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .white)),
                                                                  onPressed:
                                                                      () {
                                                                    _loginState == false?
                                                                    Get.to(() => SignInScreen(fromWhere: 5, novel: _novel, routeIndex: widget.routeIndex))
                                                                        :_nickname == 'admin'?
                                                                    _showRestrictionDialog(title: '평가 불가', content: '관리자는 작품에 별점 주기가 불가합니다.')
                                                                        :_showStarRatingDialog();
                                                                  },
                                                                ),
                                                                //소설 댓글
                                                                ElevatedButton
                                                                    .icon(
                                                                  style:
                                                                  ButtonStyle(
                                                                    padding: MaterialStateProperty.all(
                                                                        EdgeInsets
                                                                            .zero),
                                                                    backgroundColor:
                                                                    MaterialStateProperty.all(
                                                                        Colors.transparent),
                                                                    elevation:
                                                                    MaterialStateProperty.all(
                                                                        0.0),
                                                                  ),
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .sms_outlined),
                                                                  label: Text(_novel
                                                                      .commentCount
                                                                      .toString()),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              CommentListScreen(
                                                                                id: widget.id,
                                                                                appBarTitle: _novel.title,
                                                                                fromWhere: 0,
                                                                                routeIndex: widget.routeIndex,
                                                                                episodeId: 9999, // 임의값 추가
                                                                              )),
                                                                    );
                                                                  },
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                          size.height * 0.01,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: size.height * 0.07,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1, color: Colors.grey))),
                                    child: TabBar(
                                      controller: _controller,
                                      unselectedLabelColor: Colors.black,
                                      labelColor: Colors.black,
                                      tabs: const [
                                        Tab(
                                          child: Text(
                                            '홈',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                        Tab(
                                          child: Text(
                                            '작품소개',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                        Tab(
                                          child: Text(
                                            '공지사항',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ],
                                      indicatorColor: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                          body: TabBarView(
                            controller: _controller,
                            children: [
                              EpisodeList(
                                id: widget.id,
                                title: _novel.title,
                                thumbnail: _novel.thumbnail,
                                routeIndex: widget.routeIndex,
                                novel: _novel,
                                loginState: _loginState,
                              ),
                              NovelIntroduction(novel: _novel),
                              NovelNotice(
                                novelInfoId: widget.id,
                              )
                            ],
                          ),
                        ),
                        //앱바
                        SizedBox(
                          height: statusBarHeight + kToolbarHeight,
                          // 상단바 + AppBar 높이
                          child: AnimatedBuilder(
                            animation: _colorAnimationController,
                            builder: (context, build) => AppBar(
                              elevation: 0,
                              backgroundColor: _colorTween.value,
                              leading: IconButton(
                                // 좌측 액션 버튼
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                CustomBottomAppbar(
                                                  routeIndex: toBottomAppBar,
                                                )),
                                            (route) => false);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new_outlined,
                                    size: 25,
                                  ),
                                  color: _iconColorTween.value),
                              actions: [
                                _nickname == 'admin'
                                    ? _showNovelManagementOverlay(
                                    _novelManagementOverlay())
                                    : Container(),
                                _isLike == true
                                    ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isLike = false;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.redAccent,
                                    ))
                                    : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isLike = true;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.favorite_outline,
                                      color: Colors.grey,
                                      size: 30,
                                    )),
                                IconButton(
                                  // 우측 액션 버튼
                                    onPressed: () {},
                                    icon: Icon(Icons.more_vert,
                                        size: 30, color: _iconColorTween.value))
                              ],
                            ),
                          ),
                        )
                      ]),
                    ),
                  ));
            }
          } else {
            return const Text("망");
          }
        }));
  }

  //공개여부 드롭다운 구성
  Widget _novelManagementOverlay() {
    return CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            Get.off(() => NovelModifyScreen(novel: _novel));
          },
          child: const Text("작품 정보 수정"),
        ),
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            Get.off(() => EpisodeUploadScreen(
              novelId: widget.id,
              title: _novel.title,
              thumbnail: _novel.thumbnail,
            ));
          },
          child: const Text("신규 에피소드 등록"),
        ),
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            Get.to(() => NoticeUploadForm(novelInfoId: widget.id));
          },
          child: const Text("작품 공지사항 등록"),
        ),
      ],
    );
  }

  //공개여부 드롭다운 열기
  Widget _showNovelManagementOverlay(dynamic novelManagementActionSheet) {
    return IconButton(
        onPressed: () {
          showCupertinoModalPopup(
              context: context,
              builder: (context) => novelManagementActionSheet);
        },
        icon: const Icon(
          Icons.settings,
          color: Colors.black,
        ));
  }

  void _showStarRatingDialog() {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return StarRatingDialog(memberId: _memberId!, novelId: widget.id, routeIndex:widget.routeIndex);
        });
  }

  void _showRestrictionDialog({String? title, String? content}) {
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
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
