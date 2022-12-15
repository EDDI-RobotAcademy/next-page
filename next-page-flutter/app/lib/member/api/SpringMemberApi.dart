import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../http_uri.dart';
import 'requests.dart';
import 'responses.dart';

class SpringMemberApi {

  Future<bool?> emailCheck ( String email ) async {
    var data = { 'email': email };
    var body = json.encode(data);

    var response = await http.post(
      Uri.http(httpUri, '/member/check-email/$email'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      debugPrint("통신 확인");
      return json.decode(response.body);
    } else {
      throw Exception("통신 실패");
    }
  }

  Future<bool?> nicknameCheck (String nickName) async {
    var data = { 'nickName': nickName };
    var body = json.encode(data);

    var response = await http.post(
      Uri.http(httpUri, '/member/check-nickname/$nickName'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      debugPrint("통신 확인");
      return json.decode(response.body);
    } else {
      throw Exception("통신 실패");
    }
  }

  Future<bool?> signUp (SignUpRequest request) async {
    var data = { 'email': request.email, 'password': request.password, 'nickName': request.nickName };
    var body = json.encode(data);

    debugPrint(request.email);
    debugPrint(request.password);
    debugPrint(request.nickName);
    debugPrint(body);

    var response = await http.post(
      Uri.http(httpUri, '/member/sign-up'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      debugPrint("통신 확인");
      return json.decode(response.body);
    } else {
      throw Exception("통신 실패");
    }
  }

  Future<SignInResponse> signIn (SignInRequest request) async {
    var data = { 'email': request.email, 'password': request.password };
    var body = json.encode(data);

    debugPrint(request.email);
    debugPrint(request.password);
    debugPrint(body);

    var response = await http.post(
      Uri.http(httpUri, '/member/sign-in'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      debugPrint("통신 확인");
      debugPrint('userToken: '+ response.body);

      return SignInResponse(true, response.body);
    } else {
      debugPrint("통신 실패");
      return SignInResponse(false, '로그인 실패!');
    }
  }
}