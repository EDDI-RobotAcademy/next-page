
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';
import '../../utility/providers/qna_provider.dart';
import '../widgets/my_qna_list_view.dart';
import '../widgets/qna_register_form.dart';

class QnaScreen extends StatefulWidget {
  const QnaScreen({Key? key, required this.memberId}) : super(key: key);
  final int memberId;

  @override
  State<QnaScreen> createState() => _QnaScreenState();
}

class _QnaScreenState extends State<QnaScreen>
  with TickerProviderStateMixin {

  late TabController controller;
  late QnaProvider _qnaProvider;

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 2);
    _qnaProvider = Provider.of<QnaProvider>(context, listen: false);
    _qnaProvider.requestMyQnaList(widget.memberId);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('나의 QnA',
            style: TextStyle(
                color: AppTheme.pointColor,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.06),
        ),
          elevation: 0.0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.grey),
          bottom:
          TabBar(
            isScrollable: true,
            labelColor: Colors.black,
            labelStyle: TextStyle(fontSize: size.width * 0.045),
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
            QnaRegisterForm(memberId: widget.memberId,),
            MyQnaListView(memberId: widget.memberId),
          ],
        ),
      ),
    );
  }
}