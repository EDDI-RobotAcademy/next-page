import 'package:flutter/material.dart';

class NovelScreen extends StatefulWidget {
  const NovelScreen({Key? key}) : super(key: key);

  @override
  State<NovelScreen> createState() => _NovelScreenState();
}

class _NovelScreenState extends State<NovelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height *0.1,),
            Text('소설페이지')
          ],
        ),
      ),
    );
  }
}
