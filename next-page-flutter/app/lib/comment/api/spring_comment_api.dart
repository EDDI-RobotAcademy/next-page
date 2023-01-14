import 'dart:convert';

import 'package:app/comment/api/comment_reponses.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../http_uri.dart';

class SpringCommentApi {
  Future<List<CommentResponse>?> getEpisodeCommentList(int episodeId) async {
    print(episodeId);
    var response = await http.get(
        Uri.http(httpUri, '/comment/episode/$episodeId'),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      debugPrint("댓글 리스트 통신 확인");
      print(response.body.toString());
      var jsonData = jsonDecode(utf8.decode(response.bodyBytes)) as List;

      debugPrint(jsonData.toString());

      List<CommentResponse> commentResponseList =
      jsonData.map((dataJson) => CommentResponse.fromJson(dataJson)).toList();

      return commentResponseList;
    }
    throw Exception("댓글 리스트 통신 실패");
  }
}