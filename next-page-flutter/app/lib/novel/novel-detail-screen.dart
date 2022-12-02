import 'package:basic/home-screen.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter/services.dart';

class NovelDetailScreen extends StatefulWidget {
  const NovelDetailScreen({Key? key}) : super(key: key);

  @override
  State<NovelDetailScreen> createState() => _NovelDetailScreenState();
}

class _NovelDetailScreenState extends State<NovelDetailScreen> with TickerProviderStateMixin{

  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/thumbnail/tmpThumbnail1.png'),
                            fit: BoxFit.cover,)),
                    child: Column(
                      children: [
                        ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              alignment: Alignment.center,
                              color: Colors.white.withOpacity(0.1),
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: size.height * 0.05,),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 45, 0, 10),
                                      child: Image.asset(
                                          'assets/images/thumbnail/tmpThumbnail1.png'),
                                      height: 300,
                                    ),
                                    //제목
                                    Container(
                                      padding: EdgeInsets.all(7),
                                      child: Text(
                                        '근육조선',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                    // 장르 + 작가
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '판타지',
                                          style: TextStyle(
                                            color: Colors.white60,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: size.width *0.01,),
                                        Text('•', style: TextStyle(color: Colors.white60),),
                                        SizedBox(width: size.width *0.01,),
                                        Text(
                                          '차돌박E',
                                          style: TextStyle(
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
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Wrap(
                                              children: [
                                                Icon(Icons.remove_red_eye_outlined, color: Colors.white,size: 17,),
                                                Text('175만', style: TextStyle(color: Colors.white),)
                                              ],
                                            ),
                                            SizedBox(width: size.width *0.01,),
                                            Text('•', style: TextStyle(color: Colors.white),),
                                            SizedBox(width: size.width *0.01,),
                                            Wrap(
                                              children: [
                                                Icon(Icons.star, color: Colors.white,size: 17,),
                                                Text('9.7', style: TextStyle(color: Colors.white),)
                                             ],
                                            ),
                                            SizedBox(width: size.width *0.01,),
                                            Text('•', style: TextStyle(color: Colors.white),),
                                            SizedBox(width: size.width *0.01,),
                                            Wrap(
                                              children: [
                                                Icon(Icons.sms_outlined, color: Colors.white,size: 17,),
                                                Text('345', style: TextStyle(color: Colors.white),)
                                             ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.01,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios_new_outlined, size: 25,color: Colors.grey,),
                      onPressed: (){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                            builder: (BuildContext context) =>
                                HomeScreen()), (route) => false);
                      },
                    ),
                        actions: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.favorite_outline, color: Colors.grey, size: 30,)),
                          SizedBox(width: size.width * 0.03,)
                        ],
                  )),
                ],
              ),
              Container(
                height: size.height * 0.07,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: Colors.grey)
                  )
                ),
                child: TabBar(
                  controller: _controller,
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.black,
                  tabs: [
                    Tab(text: '홈', ),
                    Tab(text: '작품소개',),
                    Tab(text: '공지사항',),
                  ],
                  indicatorColor: Colors.black,
                ),
              ),
              Expanded(
                child: TabBarView(
                    controller: _controller,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          '에피소드 리스트',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          '작품 정보',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          '작품 공지사항',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
              ),
            ],
          ),
    );
  }
}
