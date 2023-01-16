import 'package:flutter/material.dart';

class NovelIntroduction extends StatelessWidget {
  final dynamic novel;

  const NovelIntroduction({Key? key, required this.novel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
                child: Text(
                  '작품소개',
                  style: TextStyle(fontSize: 22),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(_size.width * 0.03, 20, 0, 20),
                child: Text(
                  novel.introduction.replaceAll('<br>', '''
                  
 '''),
                  style: const TextStyle(fontSize: 18, height: 1.7),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(_size.width * 0.03, 20, 0, 0),
                child: Text(
                  '작품정보',
                  style: TextStyle(fontSize: 22, height: 1.7),
                ),
              ),
              SizedBox(
                height: _size.height * 0.01,
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: _size.width * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '분류',
                          style: TextStyle(fontSize: _size.width * 0.04),
                        ),
                        Text(
                          '출판사',
                          style: TextStyle(fontSize: _size.width * 0.04),
                        ),
                        Text(
                          '장르',
                          style: TextStyle(fontSize: _size.width * 0.04),
                        ),
                        Text(
                          '정가',
                          style: TextStyle(fontSize: _size.width * 0.04),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: _size.width * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '웹소설',
                            style: TextStyle(fontSize: _size.width * 0.04),
                          ),
                          Text(
                            novel.publisher,
                            style: TextStyle(fontSize: _size.width * 0.04),
                          ),
                          Text(
                            novel.category,
                            style: TextStyle(fontSize: _size.width * 0.04),
                          ),
                          Text(
                            '${novel.purchasePoint}포인트/회차 당',
                            style: TextStyle(fontSize: _size.width * 0.04),
                          ),
                        ],
                      ),
                  ),
                ],
              ),
              SizedBox(
                height: _size.height * 0.01,
              ),
              const Divider(
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(_size.width * 0.03, 20, 0, 0),
                child: const Text(
                  '작가',
                  style: TextStyle(fontSize: 22, height: 1.7),
                ),
              ),
              SizedBox(
                height: _size.height * 0.01,
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: _size.width * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '글',
                          style: TextStyle(fontSize: _size.width * 0.04),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: _size.width * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            novel.author,
                            style: TextStyle(fontSize: _size.width * 0.04),
                          ),
                        ],
                      ),
                  ),
                ],
              ),
              SizedBox(
                height: _size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
