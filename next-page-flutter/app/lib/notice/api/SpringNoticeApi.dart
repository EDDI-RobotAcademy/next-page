import 'dart:convert';

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
}