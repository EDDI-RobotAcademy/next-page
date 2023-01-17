import 'package:flutter/cupertino.dart';

import '../../novel/api/novel_requests.dart';
import '../../novel/api/spring_novel_api.dart';

class EpisodeProvider extends ChangeNotifier {
  List<dynamic> _episodeList = [];
  dynamic latestEpisode;

  List<dynamic> get episodeList => _episodeList;

  void requestEpisodeList(int page, int novelId) async {
    await SpringNovelApi()
        .getNovelEpisodeList(EpisodeRequest(page, 50, novelId))
        .then((value) {
      _episodeList = value;
      int latestEpisodeNo = _episodeList!.length;
      _episodeList.isNotEmpty
          ? latestEpisode = _episodeList[latestEpisodeNo - 1]
          : latestEpisode = null;
    });
    notifyListeners();
  }
}
