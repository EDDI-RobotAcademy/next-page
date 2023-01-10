import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../http_uri.dart';
import 'novel_requests.dart';
import 'novel_responses.dart';

class SpringNovelApi {

  Future<List<NovelListResponse>?> allNovelList() async {
    var response = await http.get(Uri.http(httpUri, '/novel/all-novel-list'),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      debugPrint("소설 리스트 통신 확인");
      var jsonData = jsonDecode(utf8.decode(response.bodyBytes)) as List;

      debugPrint(jsonData.toString());

      List<NovelListResponse> novelList =
      jsonData.map((dataJson) => NovelListResponse.fromJson(dataJson)).toList();


      return novelList;
    } else {
      throw Exception("error");
    }
  }

  Future<NovelResponse> getNovelInfo(int novelId) async {
    var response = await http.get(Uri.http(httpUri, '/novel/information-detail/$novelId'),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      debugPrint("소설 상세보기 통신 확인");
      var jsonData = jsonDecode(utf8.decode(response.bodyBytes));

      debugPrint(jsonData.toString());

      NovelResponse novel = NovelResponse.fromJson(jsonData);

      return novel;
    } else {
      throw Exception("error");
    }
  }

  /*Future<List<NovelListResponse>?> getUploaderNovelList(NovelRequest request) async {
    var response = await http.post(
      Uri.http(httpUri, '/novel/${request.memberId}/information-list'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'memberId': request.memberId,
        'size': request.size,
        'page': request.page
      }),
    );
    if (response.statusCode == 200) {
      debugPrint("통신 확인");

      var jsonData = jsonDecode(utf8.decode(response.bodyBytes));

      debugPrint(jsonData.toString());

      return json.decode(response.body);
    } else {
      throw ("error");
    }
  }*/

  Future<List<dynamic>> getNovelEpisodeList(EpisodeRequest request) async {
    var response = await http.post(Uri.http(httpUri, '/novel/episode-list/${request.novelId}'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'novelId': request.novelId,
        'size': request.size,
        'page': request.page
      }),
    );

    if (response.statusCode == 200) {
      debugPrint("소설 에피소드 리스트 통신 확인");
      LinkedHashMap<String, dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));

      return jsonData['content'];
    } else {
      throw Exception("error");
    }
  }

  Future<List<dynamic>> getPurchasedEpisodeList(PurchasedEpisodeRequest request) async {
    var response = await http.post(Uri.http(httpUri, '/episode-payment/purchased-episode-list'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'novelId': request.novelId,
        'memberId': request.memberId,
      }),
    );

    if(response.statusCode == 200){
      debugPrint("구매한 에피소드 리스트 통신 확인");

      var jsonData = jsonDecode(utf8.decode(response.bodyBytes)) as List;

      debugPrint(jsonData.toString());

      List<PurchasedEpisodeListResponse> purchasedEpisodeList =
      jsonData.map((dataJson) => PurchasedEpisodeListResponse.fromJson(dataJson)).toList();


      return purchasedEpisodeList;
    }else {
      throw ("error");
    }

  }
}
