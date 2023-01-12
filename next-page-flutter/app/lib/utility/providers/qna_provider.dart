
import 'package:app/mypage/api/spring_mypage_api.dart';
import 'package:flutter/cupertino.dart';

import '../../mypage/api/responses.dart';

class QnaProvider extends ChangeNotifier {
  List<QnA>? _myQnaList;
  List<QnA>? get myQnaList => _myQnaList;

  void requestMyQnaList(int memberId) async {
    _myQnaList = await SpringMyPageApi().getMyQnaList(memberId);
    notifyListeners();
  }
}