import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../http_uri.dart';
import 'novel_requests.dart';
import 'novel_responses.dart';

class SpringNovelApi {

  Future<List<NovelListResponse>> getAllNovelList() async {
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

  Future<List<dynamic>> getAdminNovelList(NovelRequest request) async {
    var response = await http.post(
      Uri.http(httpUri, '/novel/${request.nicnkName}/information-list'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'nickName': request.nicnkName,
        'size': request.size,
        'page': request.page
      }),
    );
    if (response.statusCode == 200) {
      debugPrint("관리자 업로드 소설 리스트 통신 확인");

      var jsonData = jsonDecode(utf8.decode(response.bodyBytes));

      debugPrint(jsonData['content'].toString());

      return jsonData['content'];
    } else {
      throw ("error");
    }
  }

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

  Future<bool> purchaseEpisode (PurchaseEpisodeRequest request) async {
    var data = { 'memberId': request.memberId, 'novelId': request.novelId, 'episodeId': request.episodeId };
    var body = json.encode(data);

    debugPrint(request.memberId.toString());
    debugPrint(request.novelId.toString());
    debugPrint(request.episodeId.toString());
    debugPrint(body);

    var response = await http.post(
      Uri.http(httpUri, '/episode-payment/buy-episode'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      debugPrint("에피소드 구매 통신 확인");
      return json.decode(response.body);
    } else {
      throw Exception("error");
    }
  }

  Future<void> requestViewCountUp(int novelId) async{
    var response = await http.get(
      Uri.http(httpUri, '/novel/view-count-up/$novelId'),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      debugPrint("통신 확인");
    } else {
      throw Exception("error");
    }
  }

  Future<bool> requestAddStarRating(AddStarRatingRequest request) async{
    var data = { 'novelId': request.novelId, 'memberId': request.memberId, 'starRating': request.starRating };
    var body = json.encode(data);

    var response = await http.post(
      Uri.http(httpUri, '/rating/add-rating'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      debugPrint("별점 주기 통신 확인");
      return json.decode(response.body);
    } else {
      throw Exception("error");
    }
  }

  Future<int> checkMyStarRating(CheckMyStarRatingRequest request) async{
    var data = { 'novelId': request.novelId, 'memberId': request.memberId};
    var body = json.encode(data);

    var response = await http.post(
      Uri.http(httpUri, '/rating/check-my-rating'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      debugPrint("별점 기록 체크 통신 확인");
      return json.decode(response.body);
    } else {
      throw Exception("error");
    }
  }

  Future<bool> requestModifyStarRating(AddStarRatingRequest request) async{
    var data = { 'novelId': request.novelId, 'memberId': request.memberId, 'starRating': request.starRating };
    var body = json.encode(data);

    var response = await http.put(
      Uri.http(httpUri, '/rating/modify-rating'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      debugPrint("별점 수정 통신 확인");
      return json.decode(response.body);
    } else {
      throw Exception("별점 수정 통신 실패");
    }
  }

  Future<bool> checkPurchaseEpisode(CheckPurchasedEpisodeRequest request) async{
    var data = {  'episodeId': request.episodeId, 'memberId': request.memberId};
    var body = json.encode(data);

    var response = await http.post(
      Uri.http(httpUri, '/episode-payment/check-purchased-episode'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      debugPrint("구매한 에피소드 수정 통신 확인");
      return json.decode(response.body);
    } else {
      throw Exception("구매한 에피소드 통신 실패");
    }
  }

  Future<List<NovelListResponse>> getNovelListByCategory(String categoryName) async {
    var data = {  'categoryName': categoryName};
    var body = json.encode(data);


    var response = await http.post(Uri.http(httpUri, '/novel/novel-list/category'),
        headers: {"Content-Type": "application/json"},
        body: body
    );

    if(response.statusCode == 200){
      debugPrint("카테고리별 소설 리스트 통신 확인");

      var jsonData = jsonDecode(utf8.decode(response.bodyBytes)) as List;


      List<NovelListResponse> novelList =
      jsonData.map((dataJson) => NovelListResponse.fromJson(dataJson)).toList();


      return novelList;
    }else {
      throw ("카테고리별 소설 리스트 통신 실패");
    }
  }

  Future<List<dynamic>> getHotShortNovelList(int size) async {
    var response = await http.get(
      Uri.http(httpUri, '/novel/novel-list/short/$size'),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      debugPrint("짧은 인기 소설 리스트 통신 확인");

      var jsonData = jsonDecode(utf8.decode(response.bodyBytes));

      debugPrint(jsonData.toString());
      List<dynamic> shortNovelList =
      jsonData.map((dataJson) => NovelListResponse.fromJson(dataJson)).toList();

      return shortNovelList;
    } else {
      throw ("error");
    }
  }
  Future<List<dynamic>> getNewShortNovelList(int size) async {
    var response = await http.get(
      Uri.http(httpUri, '/novel/new-novel-list/short/$size'),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      debugPrint("짧은 최신 소설 리스트 통신 확인");

      var jsonData = jsonDecode(utf8.decode(response.bodyBytes));

      debugPrint(jsonData.toString());
      List<dynamic> shortNovelList =
      jsonData.map((dataJson) => NovelListResponse.fromJson(dataJson)).toList();

      return shortNovelList;
    } else {
      throw ("error");
    }
  }
}
