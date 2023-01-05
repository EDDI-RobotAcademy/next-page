import 'package:flutter/material.dart';

class NovelIntroduction extends StatelessWidget {
  final String introduction;

  const NovelIntroduction({Key? key, required this.introduction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.fromLTRB(10,20,0,20),
                child: Text(
                  '작품소개',
                  style: TextStyle(
                      fontSize: 22
                  ),),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0,20,0,20),
                child: Text(
                  introduction.replaceAll('<br>',
'''
                  
 '''),
                  style: const TextStyle(
                      fontSize: 18,
                      height: 1.7
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10,20,0,0),
                child: Text(
                  '작품정보',
                  style: TextStyle(
                      fontSize: 22,
                      height: 1.7
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
