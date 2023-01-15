import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_theme.dart';
import '../novel/screens/novel_detail_screen.dart';
import '../utility/providers/comment_provider.dart';
import 'widgets/comment_list_form.dart';


class CommentListScreen extends StatefulWidget {
  final int id; // novel info id
  final String appBarTitle;
  final int fromWhere;
  final int routeIndex;
  final int episodeId;

  const CommentListScreen({Key? key, required this.appBarTitle, required this.fromWhere, required this.id, required this.routeIndex, required this.episodeId}) : super(key: key);

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
          body: CommentListForm(episodeId: widget.episodeId,)
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
                      NovelDetailScreen(id: widget.id, routeIndex: widget.routeIndex,)),
                  (route) => false)
              : Navigator.pop(context);
          /*pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ScrollNovelViewerScreen(
                        id: widget.id,
                        appBarTitle: widget.appBarTitle,
                        episode: widget.fromWhere,
                      routeIndex: widget.routeIndex,
                      )),
                  (route) => false);*/
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
                Text(
                  "(" + context.watch<CommentProvider>().commentCount.toString()+")",
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
