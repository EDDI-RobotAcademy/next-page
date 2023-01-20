
import 'package:app/mypage/api/spring_mypage_api.dart';
import 'package:flutter/cupertino.dart';

import '../../admin/api/spring_admin_api.dart';
import '../../mypage/api/responses.dart';

class QnaProvider extends ChangeNotifier {
  List<QnA>? _myQnaList;
  List<QnA>? _allQnaList;

  List<QnA>? get myQnaList => _myQnaList;
  List<QnA>? get allQnaList => _allQnaList;

  void requestMyQnaList(int memberId) async {
    _myQnaList = await SpringMyPageApi().getMyQnaList(memberId);
    notifyListeners();
  }

  void requestAllQnaList() async {
    _allQnaList = await SpringAdminApi().getAllQnaList();
    notifyListeners();
  }
}