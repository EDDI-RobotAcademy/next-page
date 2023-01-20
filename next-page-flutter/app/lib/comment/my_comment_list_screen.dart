import 'package:app/comment/my_comment_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_theme.dart';
import '../utility/providers/comment_provider.dart';


class MyCommentScreen extends StatefulWidget {
  final int memberId;

  const MyCommentScreen({Key? key, required this.memberId }) : super(key: key);

  @override
  State<MyCommentScreen> createState() => _MyCommentScreenState();
}

class _MyCommentScreenState extends State<MyCommentScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    Provider.of<CommentProvider>(context, listen: false).requestMemberCommentList(widget.memberId);
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildCommentScreenAppBar(),
        body: _isLoading ? Center(child: CircularProgressIndicator())
        : MyCommentListView(memberId: widget.memberId)
    );
  }

  AppBar _buildCommentScreenAppBar() {
    return AppBar(
      elevation: 0.4,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () { Navigator.pop(context);},
        color: Colors.black,
      ),
      backgroundColor: AppTheme.viewerAppbar,
      title: Text("댓글 내역", style: const TextStyle(color: Colors.black)),
      bottom: PreferredSize(
        preferredSize: Size(50, 50),
        child: Container(
          color: Colors.grey[100],
          constraints: BoxConstraints.expand(height: 50),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
            child: Row(
              children: [
                Text(
                  "댓글",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.01,),
                  Text("(" + context.watch<CommentProvider>().memberCommentCount.toString()+")",
                    style: TextStyle(fontSize: 15),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
