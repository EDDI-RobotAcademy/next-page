import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app_theme.dart';
import '../../novel/api/novel_responses.dart';
import '../../novel/screens/novel_detail_screen.dart';
import '../api/spring_storage_api.dart';
import '../api/storage_request.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<dynamic>? _favoriteNovelIdList;
  List<dynamic> _favoriteNovelList = [];
  int? _memberId;
  bool? _loginState;
  bool _isLoading = true;
  var now = DateTime.now();
  var format = 'yyyy-MM-dd';
  String todayString = '';
  String todayAfter1String = '';
  String todayAfter2String = '';
  bool _isFirst = true;
  bool _isFirst2 = true;

  @override
  void initState() {
    todayString = DateFormat(format).format(now).toString();
    todayAfter1String =
        DateFormat(format).format(now.subtract(Duration(days: 1))).toString();
    todayAfter2String =
        DateFormat(format).format(now.subtract(Duration(days: 2))).toString();
    _asyncMethod();
    getLikedNovelList();
    super.initState();
  }

  void _asyncMethod() async {
    var prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');
    userToken != null
        ? setState(() {
      _loginState = true;
      _memberId = prefs.getInt('userId')!;
    })
        : setState(() {
      _loginState = false;
    });
  }

  Future getLikedNovelList() async {
    await Future.delayed(Duration(milliseconds: 700), () {
      if(_loginState!){
        SpringStorageApi().getLikedNovelList(_memberId!).then((value) {
          setState(() {
            if(_isFirst2 == true) {
              _favoriteNovelIdList = value;
            }
            _isLoading = false;

          });
        });}
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    var provider = Provider.of<List<NovelListResponse>>(context);
    provider.isNotEmpty && _isLoading == false && _isFirst == true && _isFirst2 == true
        ? findFavoriteNovelList(provider)
        : print('provider 불러오는중');
    return provider.isNotEmpty && _isLoading == false &&_loginState ==true
        ? SingleChildScrollView(
      child: Column(
        children: [
          _favoriteNovelIdList!.isNotEmpty?
          buildCardList(context)
              :Column(
            children: [
              SizedBox(height: _size.height*0.26),
              Center(
                child: Text('아직 관심 등록한 소설이 없습니다.'),
              ),
            ],
          )
        ],
      ),
    )
        : _loginState == false?
    Container(
      child: Center(
        child: Text('로그인이 필요한 서비스 입니다.'),
      ),
    )
        :Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void findFavoriteNovelList(List<dynamic> provider) {
    _favoriteNovelList = [];
    for (int novelId in _favoriteNovelIdList!) {
      for (var novel in provider) {
        setState(() {
          if (novel.id == novelId) {
            _favoriteNovelList!.add(novel);
            print('거르는중');
          }
        });
        continue;
      }
    }
    setState(() {
      _isFirst = false;
      _isFirst2 == false;
    });
    print('완성된 리스트 ${_favoriteNovelList!.length}');
  }

  Widget buildCardList(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Padding(
      padding:
      EdgeInsets.fromLTRB(_size.width * 0.03, 0, _size.width * 0.03, 0),
      child: ListView.builder(
          itemCount: (_favoriteNovelList!.length > 50)
              ? 50
              : _favoriteNovelList?.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NovelDetailScreen(
                              id: _favoriteNovelList[index].id,
                              routeIndex: 3,
                            )),
                      );
                    },
                    child: Card(
                        elevation: 0.0,
                        child: Wrap(children: [
                          Container(
                            //color: Colors.yellow,
                            height: _size.height * 0.12,
                            width: _size.width * 0.9,
                            child: Row(
                              children: [
                                Stack(children: [
                                  Container(
                                    width: _size.width * 0.2,
                                    height: _size.height * 0.12,
                                    child: Image.asset(
                                      'assets/images/thumbnail/${_favoriteNovelList[index].coverImage['reName']}',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  _favoriteNovelList[index].createdDate ==
                                      todayString ||
                                      _favoriteNovelList[index]
                                          .createdDate ==
                                          todayAfter1String ||
                                      _favoriteNovelList[index]
                                          .createdDate ==
                                          todayAfter2String
                                      ? Container(
                                    color: Colors.black,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          _size.width * 0.01,
                                          0,
                                          _size.width * 0.01,
                                          0),
                                      child: Text(
                                        'new',
                                        style: TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                      : Text(''),
                                  _favoriteNovelList[index].publisher ==
                                      '넥스트페이지'
                                      ? Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      color: Colors.black,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            _size.width * 0.01,
                                            0,
                                            _size.width * 0.01,
                                            0),
                                        child: Text(
                                          '독점',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                              _size.width * 0.025),
                                        ),
                                      ),
                                    ),
                                  )
                                      : Text('')
                                ]),
                                SizedBox(
                                  width: _size.width * 0.05,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: _size.height * 0.02),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: _size.width * 0.55,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              SpringStorageApi()
                                                  .pushLike(FavoriteRequest(
                                                  _memberId!,
                                                  _favoriteNovelList[index]
                                                      .id))
                                                  .then((value) {
                                                setState(() {
                                                  for(int i =0; i<_favoriteNovelIdList!.length;i++){
                                                    print(' 이거 보여줘${_favoriteNovelIdList![i]}');
                                                    if(_favoriteNovelIdList![i] == _favoriteNovelList[index].id){
                                                      _favoriteNovelList.removeAt(index);
                                                      print('관심 소설 리스트 제거 ${_favoriteNovelList.toString()}');
                                                      print('관심 소설 리스트 제거 ${_favoriteNovelList.length}');
                                                      _favoriteNovelIdList!.removeAt(i);
                                                      print('id 리스트 제거 ${_favoriteNovelIdList.toString()}');
                                                      print('id 리스트 제거 ${_favoriteNovelIdList!.length}');
                                                      continue;
                                                    }
                                                  }
                                                });
                                              });
                                            },
                                            child: Icon(
                                              Icons.favorite,
                                              color: Colors.redAccent,
                                            )),
                                      ],
                                    ),
                                    Text(
                                      _favoriteNovelList[index].title,
                                      style: TextStyle(
                                          fontSize: _size.height * 0.017,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      _favoriteNovelList[index].author,
                                      style: TextStyle(
                                          fontSize: _size.height * 0.015),
                                    ),
                                    SizedBox(
                                      height: _size.height * 0.005,
                                    ),
                                    Container(
                                      width: _size.width * 0.6,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(children: [
                                            Icon(
                                              Icons.star,
                                              color: AppTheme.pointColor,
                                            ),
                                            _favoriteNovelList[index]
                                                .ratingCount >
                                                0
                                                ? Padding(
                                              padding: EdgeInsets.only(
                                                  top: _size.height *
                                                      0.005),
                                              child: Text((_favoriteNovelList[
                                              index]
                                                  .totalStarRating /
                                                  _favoriteNovelList[
                                                  index]
                                                      .ratingCount)
                                                  .toStringAsFixed(1)),
                                            )
                                                : Padding(
                                              padding: EdgeInsets.only(
                                                  top: _size.height *
                                                      0.005),
                                              child: Text('0.0'),
                                            )
                                          ]),
                                          SizedBox(
                                            width: _size.width * 0.01,
                                          ),
                                          Wrap(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0,
                                                    _size.height * 0.004, 0, 0),
                                                child: Text(
                                                  '${_favoriteNovelList[index].viewCount.toString()}회',
                                                  style: TextStyle(
                                                      color: Colors.grey[600]),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ]))));
          }),
    );
  }
}
