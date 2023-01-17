import 'package:app/novel/api/spring_novel_api.dart';
import 'package:app/search/search_appbar.dart';
import 'package:flutter/material.dart';

import '../../novel/screens/novel_detail_screen.dart';
import '../../novelCategory/widgets/custom_horizontal_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final int maxResultLength = 3;
  List<dynamic>? novels = []; // 전체 소설 리스트
  String _searchText = '';
  late Future<dynamic> _future;
  final FocusNode _focusNode = FocusNode();

  SearchScreenState() {
    _controller.addListener(() {
      setState(() {
        _searchText = _controller.text;
        debugPrint(_searchText);
      });
    });
  }

  @override
  void initState() {
    _future = _getAllNovelList();
    super.initState();
  }

  Future _getAllNovelList() async {
    await SpringNovelApi().allNovelList().then((novelList){
      setState(() {
        novels = novelList;
      });
    });
  }

  Widget _buildBody(BuildContext context) {
    debugPrint("_buildBody");
    if(!_focusNode.hasFocus && _searchText.isNotEmpty) {
      debugPrint("검색버튼 클릭후: " + _searchText);
      var searchResults = [];
      for (dynamic novel in novels!) {
        if (novel.title.toString().contains(_searchText) ||
            novel.author.toString().contains(_searchText)) {
          searchResults.add(novel);
        }
      }
      if(searchResults.isEmpty) {
        return Center(child: Text("일치하는 검색결과가 없습니다."));
      } else {
        return ListView.builder(
            itemCount: searchResults.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
          return CustomHorizontalCard(
              novel: searchResults[index],
              index: index
          );}
        );
      }
    } else if(_focusNode.hasFocus && _searchText.isNotEmpty) {
      // 검색창에 입력중이라면 현재 입력된 검색어가 제목에 포함된 작품 리스트를 보여줍니다.
      debugPrint("FutureBuilder");
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
                List<dynamic> searchResults = [];
                for (dynamic novel in novels!) {
                  if (novel.title.toString().contains(_searchText)) {
                    searchResults.add(novel);
                    for (dynamic s in searchResults) {
                      debugPrint(s.title);
                    }
                  }
                }
                return _buildAutoComplete(searchResults);
              }
            } else {
              return const Text("fail");
            }
          }));
    }
    else {
      // 입력창에 아무것도 적지 않았을 때 빈 화면
      return Center();
    }
  }

  Widget _buildAutoComplete(List<dynamic> searchResults) {
    debugPrint("_buildAutoComplete");
      List<Widget> autoNovelList = <Widget>[];
      if(searchResults.length > maxResultLength) {
        var resultsUpToMax = searchResults.sublist(0, maxResultLength);
        autoNovelList.addAll(resultsUpToMax.map(
            (novel) => autoCompleteListTile(novel)
        ));
      } else { autoNovelList.addAll(searchResults.map(
              (novel) => autoCompleteListTile(novel)
      ));
      }
      return  ListView( children: autoNovelList );
  }
  // 자동완성 리스트를 구성하는 list tile
  Widget autoCompleteListTile(dynamic novel) {
    return Column(
      children: [
        ListTile(
          title: Text(novel.title),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(
                builder: (context) => NovelDetailScreen( id: novel.id, routeIndex: 2)));
          },
        ),
        Divider()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: searchAppbar(_controller, _focusNode),
          body: Container(
            width: double.infinity,
            child: _buildBody(context),
            ),
          ),
    );
  }
}
