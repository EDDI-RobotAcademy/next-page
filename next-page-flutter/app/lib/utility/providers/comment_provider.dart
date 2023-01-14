import 'package:flutter/cupertino.dart';

import '../../comment/api/comment_reponses.dart';
import '../../comment/api/spring_comment_api.dart';

class CommentProvider extends ChangeNotifier {
  List<CommentResponse> _episodeCommentList = [];
  int _commentCount = 0;

  int get commentCount => _commentCount;
  List<CommentResponse>? get episodeCommentList => _episodeCommentList;

  void requestEpisodeCommentList(int episodeId) async {
    await SpringCommentApi().getEpisodeCommentList(episodeId).
    then((value) {
      _episodeCommentList = value!;
      _commentCount = _episodeCommentList.length;
      notifyListeners();
    });
  }
}