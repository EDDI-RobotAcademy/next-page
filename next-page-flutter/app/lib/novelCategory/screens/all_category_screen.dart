import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../novel/api/novel_responses.dart';
import '../../novel/api/spring_novel_api.dart';
import '../../utility/providers/novel_list_provider.dart';
import '../widgets/custom_horizontal_card.dart';

class AllCategoryScreen extends StatefulWidget {
  final int category;

  const AllCategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  String sort = "최신순";
  late Future<dynamic> _future;
  List<NovelListResponse>? _allNovelList = [];
  List<NovelListResponse>? _fantasyNovelList = [];
  List<NovelListResponse>? _chivalryNovelList = [];
  List<NovelListResponse>? _romanceNovelList = [];
  List<NovelListResponse>? _modernFantasyNovelList = [];
  List<NovelListResponse>? _blNovelList = [];
  NovelListProvider? _novelListProvider;
  bool _isLoading = true;

  @override
  void initState() {
    _novelListProvider = Provider.of<NovelListProvider>(context, listen: false);
    widget.category == 0
        ? _future = getAllNovelList()
        : widget.category == 1
        ? _novelListProvider!.getNovelList('판타지')
        : widget.category == 2
        ? _novelListProvider!.getNovelList('무협')
        : widget.category == 3
        ? _novelListProvider!.getNovelList('로맨스')
        : widget.category == 4
        ? _novelListProvider!.getNovelList('현판')
        : widget.category == 5
        ? _novelListProvider!.getNovelList('BL')
        : print('절대 나올 수 없는 메세지');

    setState(() {
      widget.category == 1 && _novelListProvider!.fantasyNovelList != null
          ? _isLoading = false
          : widget.category == 2 &&
          _novelListProvider!.chivalryNovelList != null
          ? _isLoading = false
          : widget.category == 3 &&
          _novelListProvider!.romanceNovelList != null
          ? _isLoading = false
          : widget.category == 4 &&
          _novelListProvider!.modernFantasyNovelList != null
          ? _isLoading = false
          : widget.category == 5 &&
          _novelListProvider!.blNovelList != null
          ? _isLoading = false
          : print('나오면 망');
    });

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _isLoading = false;
        _fantasyNovelList = _novelListProvider!.fantasyNovelList;
        _chivalryNovelList = _novelListProvider!.chivalryNovelList;
        _romanceNovelList = _novelListProvider!.romanceNovelList;
        _modernFantasyNovelList = _novelListProvider!.modernFantasyNovelList;
        _blNovelList = _novelListProvider!.blNovelList;

      });
    });
    super.initState();
  }

  Future getAllNovelList() async {
    await SpringNovelApi().getAllNovelList().then((novelList) {
      setState(() {
        _allNovelList = novelList;

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final actionSheet = CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            setState(() {
              sort = "최신순";
              widget.category == 0?
              _allNovelList!.sort((a,b) => b.id.compareTo(a.id))
                  :widget.category == 1?
              _fantasyNovelList!.sort((a,b) => b.id.compareTo(a.id))
                  :widget.category == 2?
              _chivalryNovelList!.sort((a,b) => b.id.compareTo(a.id))
                  :widget.category == 3?
              _romanceNovelList!.sort((a,b) => b.id.compareTo(a.id))
                  :widget.category == 4?
              _modernFantasyNovelList!.sort((a,b) => b.id.compareTo(a.id))
                  :widget.category == 5?
              _blNovelList!.sort((a,b) => b.id.compareTo(a.id))
                  :print('이거 뜨면 안돼');
            });
            Navigator.pop(context);
          },
          child: const Text("최신순"),
        ),
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            setState(() {
              sort = "인기순";
              widget.category == 0?
              _allNovelList!.sort((a,b) => b.viewCount.compareTo(a.viewCount))
                  :widget.category == 1?
              _fantasyNovelList!.sort((a,b) => b.viewCount.compareTo(a.viewCount))
                  :widget.category == 2?
              _chivalryNovelList!.sort((a,b) => b.viewCount.compareTo(a.viewCount))
                  :widget.category == 3?
              _romanceNovelList!.sort((a,b) => b.viewCount.compareTo(a.viewCount))
                  :widget.category == 4?
              _modernFantasyNovelList!.sort((a,b) => b.viewCount.compareTo(a.viewCount))
                  :widget.category == 5?
              _blNovelList!.sort((a,b) => b.viewCount.compareTo(a.viewCount))
                  :print('이거 뜨면 안돼');
            });
            Navigator.pop(context);
          },
          child: const Text("인기순"),
        )
      ],
    );

    final List<Widget> stack = <Widget>[];
    _isLoading
        ? stack.add(Stack(
      children: const <Widget>[
        Opacity(
          opacity: 0.3,
          child: ModalBarrier(dismissible: false, color: Colors.grey),
        ),
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
    ))
        : stack.add(Scaffold(
        body: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Wrap(children: [
                ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                      elevation: MaterialStateProperty.all(0.0),
                    ),
                    child: Row(
                      children: [
                        Text(
                          sort,
                          style: TextStyle(color: Colors.black),
                        ),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    onPressed: () {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) => actionSheet);
                    })
              ]),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
            ],
          ),
          Expanded(
              child: widget.category == 0
                  ? FutureBuilder(
                  future: _future,
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator());
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        return buildCardList(context);
                      }
                    } else {
                      return const Text("망");
                    }
                  }))
                  : widget.category == 1
                  ? buildCardListForCategory(context, _fantasyNovelList!)
                  : widget.category == 2
                  ? buildCardListForCategory(context, _chivalryNovelList!)
                  : widget.category == 3
                  ? buildCardListForCategory(context, _romanceNovelList!)
                  : widget.category == 4
                  ? buildCardListForCategory(context, _modernFantasyNovelList!)
                  : widget.category == 5
                  ? buildCardListForCategory(context, _blNovelList!)
                  : Text('등록된 소설이 없습니다.'))
        ])));

    return Stack(children: stack);
  }


  Widget buildCardList(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Padding(
      padding:
      EdgeInsets.fromLTRB(_size.width * 0.03, 0, _size.width * 0.03, 0),
      child: ListView.builder(
          itemCount: (_allNovelList!.length > 50) ? 50 : _allNovelList?.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return CustomHorizontalCard(
                novel: sort == '최신순'? _allNovelList![index]
                    :_allNovelList![index]
                , index: index);
          }),
    );
  }

  Widget buildCardListForCategory(BuildContext context, List<dynamic> list) {
    Size _size = MediaQuery.of(context).size;
    return Padding(
      padding:
      EdgeInsets.fromLTRB(_size.width * 0.03, 0, _size.width * 0.03, 0),
      child: ListView.builder(
          itemCount: (list!.length > 50)
              ? 50
              : list!.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return CustomHorizontalCard(
                novel: list![index],
                index: index);
          }),
    );
  }
}
