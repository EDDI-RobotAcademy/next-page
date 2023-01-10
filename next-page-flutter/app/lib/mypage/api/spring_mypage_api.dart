import 'dart:convert';

import 'package:app/mypage/api/requests.dart';
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
}