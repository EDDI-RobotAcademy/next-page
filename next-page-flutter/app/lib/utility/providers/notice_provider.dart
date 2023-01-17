import 'package:app/notice/api/notice_requests.dart';
import 'package:app/notice/api/spring_notice_api.dart';
import 'package:flutter/cupertino.dart';

import '../../notice/api/notice_responses.dart';

class NoticeProvider extends ChangeNotifier {
 List<NoticeResponse> _noticelist = [];
 List<NoticeResponse> get noticelist => _noticelist;

 void getNoticeList(NoticeRequest request) {
   SpringNoticeApi().getNoticeList(request).
   then((value){
     _noticelist = value;
     notifyListeners();
   });
 }
}
