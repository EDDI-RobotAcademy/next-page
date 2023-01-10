import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app_theme.dart';
import '../widgets/my_qna_list_view.dart';
import '../widgets/qna_register_form.dart';

class QnaScreen extends StatefulWidget {
  const QnaScreen({Key? key}) : super(key: key);

  @override
  State<QnaScreen> createState() => _QnaScreenState();
}

class _QnaScreenState extends State<QnaScreen>
  with TickerProviderStateMixin {

  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('나의 QnA',
          style: TextStyle(
            color: AppTheme.pointColor, fontWeight: FontWeight.bold),
      ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.grey,
          onPressed: () { Navigator.pop(context); },),
        elevation: 0.5,
        backgroundColor: Colors.white,
        bottom:
        TabBar(
          isScrollable: true,
          labelColor: Colors.black,
          labelStyle: TextStyle(fontSize: 18),
          tabs: [
            Container(
                width: size.width * 0.4,
                height: size.height * 0.05,
                child: Tab(text: 'QnA 작성하기')
            ),
            Container(
                width: size.width * 0.4,
                height: size.height * 0.05,
                child: Tab(text: '내가 작성한 QnA')
            )
        ],
        controller: controller,),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          QnaRegisterForm(),
          MyQnaListView(),
        ],
      ),
    );
  }
}