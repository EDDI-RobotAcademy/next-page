import 'package:basic/novel/scroll-novel-viewer-screen.dart';
import 'package:flutter/material.dart';

import 'novel-reader-screen.dart';

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
        ],
      ),
    );
  }
}
