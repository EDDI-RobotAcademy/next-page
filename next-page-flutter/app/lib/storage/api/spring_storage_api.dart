import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../http_uri.dart';
import 'storage_request.dart';

class SpringStorageApi{
  Future<List<dynamic>> getLikedNovelList(int memberId) async {
    var response = await http.get(
      Uri.http(httpUri, '/favorite/like-novel-list/$memberId'),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      print("좋아요 소설 리스트 통신 확인");

      List<dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));

      print(jsonData.toString());

      return jsonData;
    } else {
      throw ("error");
    }
  }


  /*Future<bool> checkLikeStatus(FavoriteRequest request) async{
    var data = {  'memberId': request.memberId, 'novelId': request.novelId};
    var body = json.encode(data);

    var response = await http.post(
      Uri.http(httpUri, '/favorite/like-status'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      print("좋아요 여부 통신 확인");
      return json.decode(response.body);
    } else {
      throw Exception("좋아요 통신 실패");
    }
  }

  Future<bool> pushLike(FavoriteRequest request) async{
    var data = {  'memberId': request.memberId, 'novelId': request.novelId};
    var body = json.encode(data);

    var response = await http.post(
      Uri.http(httpUri, '/favorite/push-like'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      print("좋아요 클릭 통신 확인");
      return json.decode(response.body);
    } else {
      throw Exception("좋아요 클릭 통신 실패");
    }
  }*/
}