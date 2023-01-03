import 'package:flutter/material.dart';
import 'dart:ui';

import '../../comment/comment_list_screen.dart';
import '../../widgets/custom_bottom_appbar.dart';
import '../../model/tmp_novel_model.dart';
import '../api/spring_novel_api.dart';
import '../widgets/episode_list.dart';
import '../widgets/novel_introduction.dart';
import '../widgets/novel_notice.dart';

class NovelDetailScreen extends StatefulWidget {
  final int id;
  final int routeIndex;

  const NovelDetailScreen({Key? key, required this.id, required this.routeIndex}) : super(key: key);

  @override
  State<NovelDetailScreen> createState() => _NovelDetailScreenState();
}

class _NovelDetailScreenState extends State<NovelDetailScreen>
    with TickerProviderStateMixin {

  late Future<dynamic> _future;
  dynamic _novel;
  late int toBottomAppBar;

  final ScrollController _scrollController = ScrollController();
  late TabController _controller;
  bool? _isLike = true;

  final Color _beginColor = Colors.transparent;
  final Color _endColor = Colors.white;

  final Color _beginIconColor = Colors.grey;
  final Color _endIconColor = Colors.black;

  final double _animationSpeed = 130;

  late AnimationController _colorAnimationController;
  late Animation _colorTween, _iconColorTween;

  @override
  void initState() {
    _future = getNovelInfo();
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
    if(widget.routeIndex == 0){
      toBottomAppBar = 0;
    } if(widget.routeIndex == 1){
      toBottomAppBar =1;
    }
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
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator());
          } else if (snapshot.connectionState ==
              ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return  Scaffold(
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
                                                filter:
                                                ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  color: Colors.white.withOpacity(0.1),
                                                  child: Container(
                                                    child: Column(
                                                      children: <Widget>[
                                                        //흐릿한 썸네일 배경위에 썸네일 이미지
                                                        SizedBox(
                                                          height: size.height * 0.05,
                                                        ),
                                                        Container(
                                                          padding: const EdgeInsets.fromLTRB(
                                                              0, 45, 0, 10),
                                                          height: 300,
                                                          child: Image.asset(
                                                              'assets/images/thumbnail/${_novel.thumbnail}'
                                                          ),
                                                        ),
                                                        //소설 제목
                                                        Container(
                                                          padding: const EdgeInsets.all(7),
                                                          child: Text(
                                                            _novel.title,
                                                            style: const TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                        // 장르 + 작가
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              _novel.category,
                                                              style: const TextStyle(
                                                                color: Colors.white60,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: size.width * 0.01,
                                                            ),
                                                            const Text(
                                                              '•',
                                                              style: TextStyle(
                                                                  color: Colors.white60),
                                                            ),
                                                            SizedBox(
                                                              width: size.width * 0.01,
                                                            ),
                                                            Text(
                                                              _novel.author,
                                                              style: const TextStyle(
                                                                color: Colors.white60,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Container(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                              children: [
                                                                //소설 조회수
                                                                Wrap(
                                                                  children: const [
                                                                    Icon(
                                                                      Icons
                                                                          .remove_red_eye_outlined,
                                                                      color: Colors.white,
                                                                      size: 17,
                                                                    ),
                                                                    Text(
                                                                      '175만',
                                                                      style: TextStyle(
                                                                          color:
                                                                          Colors.white),
                                                                    )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width: size.width * 0.01,
                                                                ),
                                                                const Text(
                                                                  '•',
                                                                  style: TextStyle(
                                                                      color: Colors.white),
                                                                ),
                                                                SizedBox(
                                                                  width: size.width * 0.01,
                                                                ),
                                                                //소설 별점
                                                                Wrap(
                                                                  children: [
                                                                    const Icon(
                                                                      Icons.star,
                                                                      color: Colors.white,
                                                                      size: 17,
                                                                    ),
                                                                    Text(
                                                                      TmpNovelModel
                                                                          .novelList[0].rating
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          color:
                                                                          Colors.white),
                                                                    )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width: size.width * 0.01,
                                                                ),
                                                                const Text(
                                                                  '•',
                                                                  style: TextStyle(
                                                                      color: Colors.white),
                                                                ),
                                                                SizedBox(
                                                                  width: size.width * 0.01,
                                                                ),
                                                                //소설 댓글
                                                                Wrap(
                                                                  children: [
                                                                    ElevatedButton.icon(
                                                                      style: ButtonStyle(
                                                                        padding:
                                                                        MaterialStateProperty
                                                                            .all(EdgeInsets
                                                                            .zero),
                                                                        backgroundColor:
                                                                        MaterialStateProperty
                                                                            .all(Colors
                                                                            .transparent),
                                                                        elevation:
                                                                        MaterialStateProperty
                                                                            .all(0.0),
                                                                      ),
                                                                      icon: const Icon(
                                                                          Icons.sms_outlined),
                                                                      label:
                                                                      const Text('345'),
                                                                      onPressed: () {
                                                                        Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder:
                                                                                  (context) =>
                                                                                  CommentListScreen(
                                                                                    id: widget.id,
                                                                                    appBarTitle: TmpNovelModel
                                                                                        .novelList[0]
                                                                                        .title,
                                                                                    fromWhere:
                                                                                    0,
                                                                                  )),
                                                                        );
                                                                      },
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: size.height * 0.01,
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
                                            bottom:
                                            BorderSide(width: 1, color: Colors.grey))),
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
                              ),
                              NovelIntroduction(
                                  introduction: _novel.introduction),
                              const NovelNotice()
                            ],
                          ),
                        ),
                        //앱바
                        SizedBox(
                          height: statusBarHeight + kToolbarHeight, // 상단바 + AppBar 높이
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
                                                CustomBottomAppbar(routeIndex: toBottomAppBar,)),
                                            (route) => false);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new_outlined,
                                    size: 25,
                                  ),
                                  color: _iconColorTween.value),
                              actions: [
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
          } else{
            return const Text("망");
          }
        }));







  }
}
