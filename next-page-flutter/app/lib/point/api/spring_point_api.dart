
import 'package:app/http_uri.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../point/api/request_forms.dart';

class SpringPointApi {
  Future<bool?> requestPointCharge(PointChargeForm form) async {
    var data = { 'member_id' :  form.member_id, 'payment_id' : form.payment_id,
                  'amount' : form.amount, 'point' : form.point };
    var body = json.encode(data);

    var response = await http.post(
      Uri.http(httpUri, '/point/pay-charge'),
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
}