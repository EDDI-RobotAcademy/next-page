import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

    var prefs = await SharedPreferences.getInstance();

    if (response.statusCode == 200) {
      debugPrint("통신 확인");

      Map<String, dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      prefs.setString('userToken', jsonData['userToken']);
      prefs.setString('email', jsonData['userEmail']);
      prefs.setString('nickname', jsonData['userNickName']);
      prefs.setInt('point', int.parse(jsonData['userPoint']));
      prefs.setInt('userId', int.parse(jsonData['userId']));

      return SignInResponse(true);
    } else {
      debugPrint("통신 실패");
      return SignInResponse(false);
    }
  }

  Future<bool> deleteMember(int userId) async {
    var response = await http.delete(
        Uri.http( httpUri, '/member/member-delete/$userId'),
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

  Future<int> lookUpUserPoint(MemberPointRequest request) async {
    var data = { 'memberId': request.memberId };
    var body = json.encode(data);

    debugPrint(body);

    var response = await http.post(
      Uri.http(httpUri, '/member/find-point'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      debugPrint("통신 확인");
      int userPoint = jsonDecode(utf8.decode(response.bodyBytes));

      return userPoint;
    } else {
      throw Exception("통신 실패");
    }
  }
}