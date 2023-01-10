import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_theme.dart';
import '../../member/screens/sign_in_screen.dart';
import '../api/novel_requests.dart';
import '../api/spring_novel_api.dart';
import '../screens/scroll_novel_viewer_screen.dart';
import 'custom_purchase_dialog.dart';

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
  List<dynamic>? _purchasedEpisodeList = [];
  late int _currentPoint;
  late int _memberId;
  bool _isPurchased = false;

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
      /*
      등록된 에피소드가 존재할 경우 and 로그인 상태일 경우
      소설id와 멤버id를 보내 해당 유저가 해당 소설에서 구매한 에피소드 리스트를 가져온다.
      */
      (_episodeList!.isNotEmpty && _loginState)
          ? SpringNovelApi()
          .getPurchasedEpisodeList(
          PurchasedEpisodeRequest(widget.novel.id, _memberId))
          .then((purchasedEpisodeList) {
        setState(() {
          _purchasedEpisodeList = purchasedEpisodeList;
        });
      })
          : debugPrint('등록된 에피소드가 없습니다');
    });
  }

  void _asyncMethod() async {
    var prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');
    if (userToken != null) {
      setState(() {
        _loginState = true;
        _currentPoint = prefs.getInt('point')!;
        _memberId = prefs.getInt('userId')!;
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
    Size _size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(19), bottomLeft: Radius.circular(19)),
      child: Card(
        color: AppTheme.chalk,
        child: InkWell(
          onTap: () {
            //로그인 상태일 때 에피소드 클릭시
            (_loginState)
            //유료에피소드의 경우
                ? (episode['needToBuy'])
                ? (_isPurchased)
            //구매했을 경우
                ? _payEpisodeResponse(episode)
            //구매하지 않았을 경우
                : _payEpisodeResponse(episode)
            //무료 에피소드를 클릭했을 경우
                : Get.to(ScrollNovelViewerScreen(
                episodeInfo: episode,
                author: widget.novel.author,
                episodeTitle: episode['episodeTitle'],
                text: episode['text'],
                id: widget.id,
                appBarTitle: widget.title,
                routeIndex: widget.routeIndex,
                publisher: widget.novel.publisher,
                purchasePoint: widget.novel.purchasePoint))
            //비로그인 상태일 때 에피소드 클릭시
                : Get.to(SignInScreen(
              fromWhere: 5,
              novel: widget.novel,
              routeIndex: widget.routeIndex,
            ));
          },
          child: Row(
            children: <Widget>[
              //에피소드 리스트 내의 작은 소설 썸네일
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
              Container(
                width: _size.width * 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //소설 제목과 에피소드 화
                      Text(
                        '${widget.title} ${episode['episodeNumber'].toString()}화',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 17),
                      ),
                      //에피소드의 업로드 일자
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(episode['uploadedDate']),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: _size.width * 0.15,
              ),
              (episode['needToBuy'])
                  ? _payEpisodeTxt(episode)
              //무료 에피소드의 경우 에피소드 리스트 하단에 무료 텍스트가 보이도록 한다.
                  : Row(
                children: [
                  SizedBox(
                    width: _size.width * 0.04,
                  ),
                  Text(
                    '무료',
                    style: TextStyle(
                        color: AppTheme.pointColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context, Widget alert) {
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  Widget _payEpisodeTxt(dynamic episode) {
    for (int i = 0; i < _purchasedEpisodeList!.length; i++) {
      _isPurchased = false;
      if (_purchasedEpisodeList![i].episodeId == episode['id']) {
        _isPurchased = true;
        break;
      }
    }
    return (_isPurchased)
    //구매한 유료 소설의 경우 리스트 우측에 보기, 구매완료 텍스트가 보이도록 한다.
        ? Column(
      children: [
        Text(
          '보기',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('구매완료'),
      ],
    )
    //구매하지 않은 유료 소설의 경우 다운로드 아이콘이 보이도록 한다.
        : Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.04,
        ),
        Icon(
          Icons.file_download_outlined,
          color: Colors.grey[600],
        ),
      ],
    );
  }

  _payEpisodeResponse(dynamic episode) {
    for (int i = 0; i < _purchasedEpisodeList!.length; i++) {
      _isPurchased = false;
      print(_purchasedEpisodeList![i].episodeId);
      print(episode['id']);
      if (_purchasedEpisodeList![i].episodeId == episode['id']) {
        _isPurchased = true;
        break;
      }
    }
    return (_isPurchased)
    //구매한 유료 에피소드를 클릭할 경우 뷰어로 이동
        ? Get.to(() => ScrollNovelViewerScreen(
        episodeInfo: episode,
        author: widget.novel.author,
        episodeTitle: episode['episodeTitle'],
        text: episode['text'],
        id: widget.id,
        appBarTitle: widget.title,
        routeIndex: widget.routeIndex,
        publisher: widget.novel.publisher,
        purchasePoint: widget.novel.purchasePoint))
    //구매하지 않은 유로 에피소드를 클릭할 경우 구매 dialog로 이동
        : _showAlertDialog(
        context,
        CustomPurchaseDialog(
          novelTitle: widget.title,
          purchasePoint: widget.novel.purchasePoint.toString(),
          point: _currentPoint.toString(),
          episode: episode['episodeNumber'].toString(),
        ));
  }
}
