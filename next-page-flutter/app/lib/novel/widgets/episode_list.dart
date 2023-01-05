import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_theme.dart';
import '../../member/screens/sign_in_screen.dart';
import '../api/novel_requests.dart';
import '../api/spring_novel_api.dart';
import '../screens/scroll_novel_viewer_screen.dart';

class EpisodeList extends StatefulWidget {
  final dynamic novel;
  final String thumbnail;
  final int id;
  final String title;
  final int routeIndex;

  const EpisodeList(
      {Key? key,
      required this.thumbnail,
      required this.id,
      required this.title,
      required this.routeIndex,
      required this.novel})
      : super(key: key);

  @override
  State<EpisodeList> createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {
  late Future<dynamic>? _future;
  late bool _loginState;
  List<dynamic>? _episodeList = [];

  @override
  void initState() {
    _future = _getEpisodeList();
    Future.delayed(Duration.zero, () async {
      _asyncMethod();
    });
    super.initState();
  }

  Future _getEpisodeList() async {
    await SpringNovelApi()
        .getNovelEpisodeList(EpisodeRequest(0, 100, widget.id))
        .then((episodeList) {
      setState(() {
        _episodeList = episodeList;
      });
      print(episodeList.toString());
    });
  }

  void _asyncMethod() async {
    var prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');
    if (userToken != null) {
      setState(() {
        _loginState = true;
      });
    } else {
      setState(() {
        _loginState = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return (_episodeList!.length > 0)
                  ? Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: _episodeList!.map((episode) {
                            return _episodeCardList(episode);
                          }).toList(),
                        ),
                      ),
                    )
                  : const Center(
                      child: Text('등록된 에피소드가 없습니다.'),
                    );
            }
          } else {
            return const Text("망");
          }
        }));
  }

  Widget _episodeCardList(dynamic episode) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(19), bottomLeft: Radius.circular(19)),
      child: Card(
        color: AppTheme.chalk,
        child: InkWell(
          onTap: () {
            print(_loginState);
            (_loginState)
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ScrollNovelViewerScreen(
                            episodeInfo: episode,
                            author: widget.novel.author,
                            episodeTitle: episode['episodeTitle'],
                            text: episode['text'],
                            id: widget.id,
                            appBarTitle: widget.title,
                            routeIndex: widget.routeIndex,
                            publisher: widget.novel.publisher,
                          purchasePoint: widget.novel.purchasePoint

                        )),
                  )
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignInScreen(
                              fromWhere: 5,
                              novel: widget.novel,
                              routeIndex: widget.routeIndex,
                            )),
                  );
          },
          child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.13,
                height: MediaQuery.of(context).size.height * 0.08,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/thumbnail/${widget.thumbnail}'),
                        fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${widget.title} ${episode['episodeNumber'].toString()}화',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(episode['uploadedDate']),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
