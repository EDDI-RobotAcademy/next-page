import 'package:flutter/cupertino.dart';

class CategoryProvider extends ChangeNotifier {
  String _category = '';
  String get category => _category;

  void categorySelected(String selectedCategory) {
    _category = selectedCategory;
    notifyListeners();
  }

  void categoryReset() {
    _category = '';
    notifyListeners();
  }
}