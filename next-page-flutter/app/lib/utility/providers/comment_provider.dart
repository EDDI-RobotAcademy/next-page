import 'package:flutter/cupertino.dart';

import '../../comment/api/comment_responses.dart';
import '../../comment/api/spring_comment_api.dart';

class CommentProvider extends ChangeNotifier {
  List<CommentResponse> _episodeCommentList = [];
  List<CommentAndEpisodeResponse> _novelCommentList = [];
  int _episodeCommentCount = 0;
  int _novelCommentCount = 0;

  int get episodeCommentCount => _episodeCommentCount;
  int get novelCommentCount => _novelCommentCount;

  List<CommentResponse>? get episodeCommentList => _episodeCommentList;
  List<CommentAndEpisodeResponse>? get novelCommentList => _novelCommentList;

  void requestEpisodeCommentList(int episodeId) async {
    await SpringCommentApi().getEpisodeCommentList(episodeId).
    then((value) {
      _episodeCommentList = value!;
      _episodeCommentList.sort((a, b) => b.commentNo.compareTo(a.commentNo));
      _episodeCommentCount = _episodeCommentList.length;
      notifyListeners();
    });
  }

  void requestNovelCommentList(int novelInfoId) async {
    await SpringCommentApi().getNovelCommentList(novelInfoId).
    then((value) {
      _novelCommentList = value!;
      _novelCommentList.sort((a, b) => b.commentNo.compareTo(a.commentNo));
      _novelCommentCount = _novelCommentList.length;
      notifyListeners();
    });
  }
}