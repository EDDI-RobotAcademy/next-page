import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../http_uri.dart';
import 'pedometer_request.dart';

class SpringPedometerApi{

  Future<bool> requestCheckPedometer(CheckPedometerRequest request) async{
    var data = { 'id': request.memberId, 'nowDate': request.nowDate};
    var body = json.encode(data);

    var response = await http.post(
      Uri.http(httpUri, '/pedometer/check/today'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      print("오늘의 만보기 통신 확인");
      return json.decode(response.body);
    } else {
      throw Exception("error");
    }
  }

  /*Future<bool> getPointByPedometer(int memberId) async{
    var response = await http.get(
      Uri.http(httpUri, '/pedometer/get-point/$memberId'),
      headers: {"Content-Type": "application/json"},
    );

    var prefs = await SharedPreferences.getInstance();
    int? prevPoint = prefs.getInt('point');



    if (response.statusCode == 200) {
      print("포인트 획득 통신 확인");
      prefs.setInt('point', (prevPoint!+300));
      return true;
    } else {
      throw Exception("error");
    }
  }*/
}