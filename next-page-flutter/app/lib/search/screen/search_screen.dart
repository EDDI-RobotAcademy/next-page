
import 'package:app/search/search_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../novel/api/novel_responses.dart';
import '../../novel/screens/novel_detail_screen.dart';
import '../../novelCategory/widgets/custom_horizontal_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller = TextEditingController();
  final int maxResultLength = 3;
  List<dynamic>? novels = []; // 전체 소설 리스트
  String _searchText = '';

  final FocusNode _focusNode = FocusNode();
  bool submitted = false;

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
    super.initState();
  }

  Widget _buildBody(BuildContext context) {
    debugPrint("_buildBody");
    print('첫 빌드 submitted: ' + submitted.toString());
    if (submitted) {
      //검색어를 입력하고 검색
      debugPrint("검색버튼 클릭후: " + _searchText);
      submitted = false;
      var searchResults = [];
      for (dynamic novel in novels!) {
        if (novel.title.toString().contains(_searchText) ||
            novel.author.toString().contains(_searchText)) {
          searchResults.add(novel);
        }
      }
      if (searchResults.isEmpty) {
        return Center(child: Text("일치하는 검색결과가 없습니다."));
      } else {
        return ListView.builder(
            itemCount: searchResults.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return CustomHorizontalCard(
                  novel: searchResults[index], index: index);
            });
      }
    } else {
      if (_searchText.isEmpty) {
        return Center();
      } else {
        //검색어 입력 중일 때 자동완성
        List<dynamic> searchResults = [];
        for (dynamic novel in novels!) {
          if (novel.title.toString().contains(_searchText)) {
            searchResults.add(novel);
            for (dynamic s in searchResults) {
              debugPrint("자동완성 리스트: " + s.title);
            }
          }
        }
        return _buildAutoComplete(searchResults);
      }
    }
  }

  Widget _buildAutoComplete(List<dynamic> searchResults) {
    debugPrint("_buildAutoComplete");
    List<Widget> autoNovelList = <Widget>[];
    if (searchResults.length > maxResultLength) {
      var resultsUpToMax = searchResults.sublist(0, maxResultLength);
      autoNovelList
          .addAll(resultsUpToMax.map((novel) => autoCompleteListTile(novel)));
    } else {
      autoNovelList
          .addAll(searchResults.map((novel) => autoCompleteListTile(novel)));
    }
    return ListView(children: autoNovelList);
  }

  // 자동완성 리스트를 구성하는 list tile
  Widget autoCompleteListTile(dynamic novel) {
    return Column(
      children: [
        ListTile(
          title: Text(novel.title),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NovelDetailScreen(id: novel.id, routeIndex: 2)));
          },
        ),
        Divider()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<List<NovelListResponse>>(context);
    provider.isEmpty ? print('검색 페이지 전체 리스트 프로바이더 소환중') : novels = provider;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: SearchAppBar(
          controller: _controller,
          focusNode: _focusNode,
        ),
        body: provider.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Container(
                width: double.infinity,
                child: _buildBody(context),
              ),
      ),
    );
  }
}
