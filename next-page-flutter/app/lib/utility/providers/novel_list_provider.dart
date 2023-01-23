import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '../../novel/api/novel_responses.dart';
import '../../novel/api/spring_novel_api.dart';
import 'package:http/http.dart' as http;

import '../../http_uri.dart';

class NovelListProvider extends ChangeNotifier {
  List<NovelListResponse> allNovelList = [];
  List<NovelListResponse>? _fantasyNovelList;
  List<NovelListResponse>? _chivalryNovelList;
  List<NovelListResponse>? _romanceNovelList;
  List<NovelListResponse>? _modernFantasyNovelList;
  List<NovelListResponse>? _blNovelList;



  List<NovelListResponse>? get fantasyNovelList => _fantasyNovelList;

  List<NovelListResponse>? get chivalryNovelList => _chivalryNovelList;

  List<NovelListResponse>? get romanceNovelList => _romanceNovelList;

  List<NovelListResponse>? get modernFantasyNovelList =>
      _modernFantasyNovelList;

  List<NovelListResponse>? get blNovelList => _blNovelList;

  void getNovelList(String categoryName) {
    SpringNovelApi()
        .getNovelListByCategory(categoryName)
        .
    then((value) {
      if (categoryName == '판타지') {
        _fantasyNovelList = value;
        _fantasyNovelList!.sort((a,b) => b.id.compareTo(a.id));
      } else if (categoryName == '무협') {
        _chivalryNovelList = value;
        _chivalryNovelList!.sort((a,b) => b.id.compareTo(a.id));
      }
      else if (categoryName == '로맨스') {
        _romanceNovelList = value;
        _romanceNovelList!.sort((a,b) => b.id.compareTo(a.id));

      }
      else if (categoryName == '현판') {
        _modernFantasyNovelList = value;
        _modernFantasyNovelList!.sort((a,b) => b.id.compareTo(a.id));

      }
      else if (categoryName == 'BL') {
        _blNovelList = value;
        _blNovelList!.sort((a,b) => b.id.compareTo(a.id));

      }
      notifyListeners();
    }
    );
  }

  void getAllNovelList() async{
    allNovelList = await SpringNovelApi().getAllNovelList();
    notifyListeners();
  }

  Future<List<NovelListResponse>> futureGetAllNovelList() async {
    var response = await http.get(Uri.http(httpUri, '/novel/all-novel-list'),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      debugPrint("소설 리스트 통신 확인");
      var jsonData = jsonDecode(utf8.decode(response.bodyBytes)) as List;

      debugPrint(jsonData.toString());

      List<NovelListResponse> novelList =
      jsonData.map((dataJson) => NovelListResponse.fromJson(dataJson)).toList();


      allNovelList = novelList;
      notifyListeners();
      return novelList;
    } else {
      throw Exception("error");
    }
  }


}
