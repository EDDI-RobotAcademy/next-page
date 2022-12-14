import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../novel/screens/novel_detail_screen.dart';
import '../novel/screens/scroll_novel_viewer_screen.dart';
import 'widgets/comment_list_form.dart';


class CommentListScreen extends StatefulWidget {
  final String appBarTitle;
  final int fromWhere;

  const CommentListScreen({Key? key, required this.appBarTitle, required this.fromWhere}) : super(key: key);

  @override
  State<CommentListScreen> createState() => _CommentListScreenState();
}

class _CommentListScreenState extends State<CommentListScreen> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: _buildCommentScreenAppBar(),
        body: CommentListForm()
      ),
    );
  }

  AppBar _buildCommentScreenAppBar() {
    return AppBar(
      elevation: 0.4,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          (widget.fromWhere == 0) ?
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                  const NovelDetailScreen()),
                  (route) => false)
              : Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ScrollNovelViewerScreen(
                        appBarTitle: widget.appBarTitle,
                        episode: widget.fromWhere,)),
                  (route) => false);
        },
        color: Colors.black,
      ),
      backgroundColor: AppTheme.viewerAppbar,
      title: (widget.fromWhere == 0) ?
      Text(widget.appBarTitle, style: const TextStyle(color: Colors.black),)
          : Text('${widget.appBarTitle} ${widget.fromWhere}화',
        style: TextStyle(color: Colors.black),),
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
                Text('(34)',
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
