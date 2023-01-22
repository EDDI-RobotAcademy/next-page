import 'dart:convert';

import 'package:app/comment/api/comment_responses.dart';
import 'package:app/comment/api/comment_requests.dart';
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

  Future<bool> writeComment(int episodeId, CommentWriteRequest request) async {
    var data = { 'commentWriterId' : request.memberId, 'comment' : request.comment };
    var body = json.encode(data);
    print("write comment: " + body);

    var response = await http.post(
      Uri.http( httpUri, '/comment/write/$episodeId'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if(response.statusCode == 200) {
      debugPrint("댓글 작성 통신 확인");
      return true;
    } else {
      debugPrint("댓글 작성 통신 실패");
      return false;
    }
  }

  Future<bool> modifyComment(int episodeId, String comment) async {
    var data = { 'comment' : comment };
    var body = json.encode(data);
    print("modify comment: " + body);

    var response = await http.put(
      Uri.http( httpUri, '/comment/modify/$episodeId'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if(response.statusCode == 200) {
      debugPrint("댓글 수정 통신 확인");
      return true;
    } else {
      debugPrint("댓글 수정 통신 실패");
      return false;
    }
  }

  Future<bool> deleteComment(int episodeId) async {
    var response = await http.delete(
      Uri.http( httpUri, '/comment/delete/$episodeId'),
      headers: {"Content-Type": "application/json"},
    );

    if(response.statusCode == 200) {
      debugPrint("통신 확인");
      return true;
    } else {
      debugPrint("통신 실패");
      return false;
    }
  }

  Future<List<CommentAndEpisodeResponse>?> getNovelCommentList(int novelInfoId) async {
    print("novelInfoId: " + novelInfoId.toString());
    var response = await http.get(
        Uri.http(httpUri, '/comment/novel-comment-list/$novelInfoId'),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      debugPrint("댓글 리스트 통신 확인");
      print(response.body.toString());
      var jsonData = jsonDecode(utf8.decode(response.bodyBytes)) as List;

      debugPrint(jsonData.toString());

      List<CommentAndEpisodeResponse> commentResponseList =
      jsonData.map((dataJson) => CommentAndEpisodeResponse.fromJson(dataJson)).toList();

      return commentResponseList;
    }
    throw Exception("댓글 리스트 통신 실패");
  }

  Future<List<CommentAndEpisodeResponse>?> getMemberCommentList(int memberId) async {
    print("memberId: " + memberId.toString());
    var response = await http.get(
        Uri.http(httpUri, '/comment/member-comment-list/$memberId'),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      debugPrint("멤버 댓글 리스트 통신 확인");
      print(response.body.toString());
      var jsonData = jsonDecode(utf8.decode(response.bodyBytes)) as List;

      debugPrint(jsonData.toString());

      List<CommentAndEpisodeResponse> commentResponseList =
      jsonData.map((dataJson) => CommentAndEpisodeResponse.fromJson(dataJson)).toList();

      return commentResponseList;
    }
    throw Exception("멤버 댓글 리스트 통신 실패");
  }
}