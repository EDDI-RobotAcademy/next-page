import 'package:flutter/cupertino.dart';
import '../../novel/api/novel_responses.dart';
import '../../novel/api/spring_novel_api.dart';

class NovelListProvider extends ChangeNotifier {
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
}
