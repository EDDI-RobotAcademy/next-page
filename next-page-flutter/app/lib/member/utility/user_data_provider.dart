import 'package:flutter/cupertino.dart';

class UserDataProvider extends ChangeNotifier{
  bool _loginState = false;
  String? _userToken = '';

  int _point = 0;

  bool get loginState => _loginState;
  String? get userToken => _userToken;
  int get point => _point;

  void isLogin() {
    _loginState = true;
    notifyListeners();
  }

  void setUserToken(String resToken) {
    _userToken = resToken;
  }

  void requestPointData() {
    // _point = 로그인한 사용자의 포인트 조회 api
    notifyListeners();
  }

}