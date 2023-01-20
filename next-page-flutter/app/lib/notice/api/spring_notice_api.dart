import 'dart:collection';
import 'dart:convert';

import 'package:app/notice/api/notice_responses.dart';

import '../../http_uri.dart';
import 'notice_requests.dart';
import 'package:http/http.dart' as http;

class SpringNoticeApi{

  Future<bool> writeNotice(WriteNoticeRequest request) async {
    var data = { 'title': request.title, 'content': request.content,
      'noticeCategory': request.noticeCategory, 'novelInfoId' : request.novelInfoId };
    var body = json.encode(data);

    print(body);

    var response = await http.post(
      Uri.http(httpUri, '/notice/write'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      print("공지 작성 통신 확인");
      return json.decode(response.body);
    } else {
      print("공지 작성 통신 실패");
      return false;
    }
  }

  Future<List<NoticeResponse>> getNoticeList(NoticeRequest request) async {
    var response = await http.post(Uri.http(httpUri, '/notice/get-list'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'novelInfoId': request.novelInfoId,
        'size': request.size,
        'page': request.page
      }),
    );

    if (response.statusCode == 200) {
      print("공지사항 리스트 통신 확인");

      LinkedHashMap<String, dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));

      print('공지사항 데이터 확인' + jsonDecode(utf8.decode(response.bodyBytes)).toString());

      var tmpJsonList = jsonData['content'] as List;
      List<NoticeResponse> noticeList =
      tmpJsonList.map((json)=> NoticeResponse.fromJson(json)).toList();

      return noticeList;
    } else {
      throw Exception("공지사항 리스트 통신 에러");
    }
  }

  Future<bool> deleteNotice(int noticeId) async {
    var response = await http.delete(
      Uri.http( httpUri, '/notice/delete/$noticeId'),
      headers: {"Content-Type": "application/json"},
    );

    if(response.statusCode == 200) {
      print("공지 삭제 통신 확인");
      return true;
    } else {
      print("공지 삭제 통신 에러");
      return false;
    }
  }
}