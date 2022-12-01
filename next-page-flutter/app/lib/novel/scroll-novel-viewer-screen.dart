import 'package:basic/model/tmp-novel-model.dart';
import 'package:basic/novel/sliding-appbar.dart';
import 'package:flutter/material.dart';

class ScrollNovelViewerScreen extends StatefulWidget {
  const ScrollNovelViewerScreen({Key? key}) : super(key: key);

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
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
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
            child: AppBar(
              backgroundColor:
              (visible) ? Color(0xFFE4E4E4) : Colors.transparent,
              elevation: 0.0,
              title: Text(
                "${TmpNovelModel.episodeList[0].episode}화",
                style: TextStyle(color: Colors.black),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.settings,
                      color: Colors.black,
                    ))
              ],
            )),
        extendBodyBehindAppBar: true,
        body: GestureDetector(
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
            child: ListView(
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Text(
                        TmpNovelModel.episodeList[0].content,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: AnimatedContainer(
            duration: Duration(milliseconds: 400),
            height: visible ? size.height * 0.1 : 0.0,
            child: visible
                ? Container(
              color: Color(0xFFE4E4E4),
              child: Center(
                child: Column(
                  children: [
                    Text("부가기능 고민중"),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10,0,10,0),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_back_ios)),
                          Spacer(flex: 1,),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_back_ios)),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_forward_ios))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
                : Container()));
  }
}

/*
*/
