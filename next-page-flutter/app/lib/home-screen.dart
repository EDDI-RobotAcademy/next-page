import 'package:basic/novel/novel-detail-screen.dart';
import 'package:basic/novel/scroll-novel-viewer-screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height * 0.1,
          ),
          Text("메인페이지"),
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ScrollNovelViewerScreen()));
              },
              child: Text("리스트뷰 방식 읽기")),
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NovelDetailScreen()));
              },
              child: Text("소설 상세보기 페이지")),

        ],
      ),
    );
  }
}
