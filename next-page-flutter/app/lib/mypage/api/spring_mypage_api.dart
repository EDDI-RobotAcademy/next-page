import 'dart:convert';

import 'package:app/mypage/api/requests.dart';
import 'package:app/mypage/api/responses.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../http_uri.dart';

class SpringMyPageApi {

  Future<bool> qnaRegister (QnaRegisterRequest request) async {
    var data = { 'memberId': request.memberId, 'title': request.title,
                  'category': request.category, 'content' : request.content };
    var body = json.encode(data);

    debugPrint(body);

    var response = await http.post(
      Uri.http(httpUri, '/qna/register'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      debugPrint("통신 확인");
      return json.decode(response.body);
    } else {
      debugPrint("통신 실패");
      return false;
    }
  }

  Future<List<QnA>?> getMyQnaList (int memberId) async {

    var response = await http.get(
      Uri.http(httpUri, '/qna/my-qna-list/$memberId'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      debugPrint("getMyQnaList 통신 확인");

      var jsonData = jsonDecode(utf8.decode(response.bodyBytes)) as List;

      debugPrint(jsonData.toString());

      List<QnA> myQnaList = jsonData.map((dataJson) => QnA.fromJson(dataJson)).toList();

      return myQnaList;

    } else {
      throw Exception("getMyQnaList 통신 실패");
    }
  }

  Future<void> deleteQna(int qnaNo) async {

    var response = await http.delete(
      Uri.http(httpUri, '/qna/$qnaNo'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      debugPrint("deleteQna 통신 확인");
    } else {
      debugPrint("deleteQna 통신 실패");
    }
  }
}