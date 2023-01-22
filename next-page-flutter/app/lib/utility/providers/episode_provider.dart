import 'package:flutter/cupertino.dart';

import '../../novel/api/novel_requests.dart';
import '../../novel/api/spring_novel_api.dart';

class EpisodeProvider extends ChangeNotifier {
  List<dynamic> _episodeList = [];
  dynamic latestEpisode;
  int? episodesLength;


  List<dynamic> get episodeList => _episodeList;

  void requestEpisodeList(int page, int novelId) async {
    await SpringNovelApi()
        .getNovelEpisodeList(EpisodeRequest(page, 50, novelId))
        .then((value) {
      _episodeList = value;
      _episodeList!.sort((a,b) => a['episodeNumber'].compareTo(b['episodeNumber']));
      episodesLength = _episodeList!.length;
      _episodeList.isNotEmpty
          ? latestEpisode = _episodeList[episodesLength! - 1]
          : latestEpisode = null;
    });
    notifyListeners();
  }
}
