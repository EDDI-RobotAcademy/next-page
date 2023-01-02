import 'package:flutter/material.dart';

import '../../novel/api/spring_novel_api.dart';
import 'custom_vertical_card.dart';


class CustomCardList extends StatefulWidget {
  final int sortOfList;

  const CustomCardList({Key? key, required this.sortOfList}) : super(key: key);

  @override
  State<CustomCardList> createState() => _CustomCardListState();
}

class _CustomCardListState extends State<CustomCardList> {
  late Future<dynamic> _future;
  List<dynamic>? _allNovelList = [];
  late String _listTitle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = getAllNovelList();
    setState(() {
      (widget.sortOfList == 0)
          ?_listTitle = 'New 연재 작품'
          :_listTitle = '실시간 인기 작품';
    });
  }

  Future getAllNovelList() async {
    await SpringNovelApi().allNovelList().then((novelList) {
      setState(() {
        _allNovelList = novelList;
      });
    });
  }
  Widget buildCardList(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.03, 0, size.width * 0.03, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _listTitle,
            style: TextStyle(
                fontSize: size.width * 0.05, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: size.height * 0.01,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: size.height * 0.28,
              child: ListView.builder(
                  itemCount: (_allNovelList!.length > 15)
                      ? 15
                      : _allNovelList?.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomVerticalCard(
                        novel: _allNovelList?[index]);
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
          } else{
            return const Text("망");
          }
        }));
  }
}
