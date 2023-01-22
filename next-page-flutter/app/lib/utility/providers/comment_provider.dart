import 'package:flutter/cupertino.dart';

import '../../comment/api/comment_responses.dart';
import '../../comment/api/spring_comment_api.dart';

class CommentProvider extends ChangeNotifier {
  List<CommentResponse> _episodeCommentList = [];
  List<CommentAndEpisodeResponse> _novelCommentList = [];
  List<CommentAndEpisodeResponse> _memberCommentList = [];

  int _episodeCommentCount = 0;
  int _novelCommentCount = 0;
  int _memberCommentCount = 0;

  int get episodeCommentCount => _episodeCommentCount;
  int get novelCommentCount => _novelCommentCount;
  int get memberCommentCount => _memberCommentCount;

  List<CommentResponse>? get episodeCommentList => _episodeCommentList;
  List<CommentAndEpisodeResponse>? get novelCommentList => _novelCommentList;
  List<CommentAndEpisodeResponse> get memberCommentList => _memberCommentList;

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

  void requestMemberCommentList(int memberId) async {
    await SpringCommentApi().getMemberCommentList(memberId).
    then((value) {
      _memberCommentList = value!;
      _memberCommentCount = _memberCommentList.length;
      notifyListeners();
    });
  }
}