import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../novel/api/spring_novel_api.dart';
import '../../utility/providers/novel_list_provider.dart';
import 'custom_vertical_card.dart';

class CustomNewCardList extends StatefulWidget {

  const CustomNewCardList({Key? key}) : super(key: key);

  @override
  State<CustomNewCardList> createState() => _CustomNewCardListState();
}

class _CustomNewCardListState extends State<CustomNewCardList> {
  NovelListProvider? _novelListProvider;
  List<dynamic>? _newNovelList;
  var _future;

  @override
  void initState() {
    _novelListProvider = Provider.of<NovelListProvider>(context, listen: false);
    _future = _getHotNovelList();
    super.initState();
  }

  _getHotNovelList() async {
    _newNovelList = await SpringNovelApi().getNewShortNovelList(15);
  }


  Widget buildCardList(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return
      Padding(
      padding:
          EdgeInsets.fromLTRB(_size.width * 0.03, 0, _size.width * 0.03, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'New 연재 작품',
            style: TextStyle(
                fontSize: _size.width * 0.05, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: _size.height * 0.01,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: _size.height * 0.28,
              child: ListView.builder(
                  itemCount: (_newNovelList!.length > 15)
                      ? 15
                      : _newNovelList!.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomVerticalCard(
                        novel: _newNovelList![index]);
                  }),
            ),
          ),
        ],
      ),
    );
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
              return buildCardList(context);
            }
          } else {
            return const Text("망");
          }
        }));
  }
}
