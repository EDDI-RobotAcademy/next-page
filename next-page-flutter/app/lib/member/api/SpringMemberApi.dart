import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'requests.dart';
import 'responses.dart';

class SpringMemberApi {
  String httpUri = '192.168.1.104:7777';

  Future<SignInResponse> signIn (SignInRequest request) async {
    var data = { 'email': request.email, 'password': request.password };
    var body = json.encode(data);

    debugPrint(request.email);
    debugPrint(request.password);
    debugPrint(body);

    var response = await http.post(
      Uri.http(httpUri, '실제 요청 주소'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      debugPrint("통신 확인");
      debugPrint(response.body);

      return SignInResponse(true, response.body);
    } else {
      debugPrint("로그인 실패");
      return SignInResponse(false, '로그인 실패!');
    }
  }
}