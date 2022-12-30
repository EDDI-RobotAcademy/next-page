import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../http_uri.dart';
import 'novel_requests.dart';

class SpringNovelApi {

  Future<List<NovelListRequest>?> allNovelList() async {
    var response = await http.get(Uri.http(httpUri, '/novel/all-novel-list'),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      debugPrint("소설 리스트 통신 확인");
      var jsonData = jsonDecode(utf8.decode(response.bodyBytes)) as List;

      debugPrint(jsonData.toString());

      List<NovelListRequest> novelList =
      jsonData.map((dataJson) => NovelListRequest.fromJson(dataJson)).toList();


      return novelList;
    } else {
      throw Exception("error");
    }
  }

  Future<NovelRequest> getNovelInfo(int novelId) async {
    var response = await http.get(Uri.http(httpUri, '/novel/information-detail/$novelId'),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      debugPrint("소설 상세보기 통신 확인");
      var jsonData = jsonDecode(utf8.decode(response.bodyBytes));

      debugPrint(jsonData.toString());

      NovelRequest novel = NovelRequest.fromJson(jsonData);

      return novel;
    } else {
      throw Exception("error");
    }
  }
}

