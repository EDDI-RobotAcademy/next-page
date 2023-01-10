import 'package:flutter/cupertino.dart';

class MyQnaListView extends StatefulWidget {
  const MyQnaListView({Key? key}) : super(key: key);

  @override
  State<MyQnaListView> createState() => _MyQnaListViewState();
}

class _MyQnaListViewState extends State<MyQnaListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text('내가 작성한 qna 리스트~~')
      ],

    );
  }

}