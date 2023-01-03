import 'package:flutter/material.dart';

import '../../novel/api/spring_novel_api.dart';
import 'custom_horizontal_card.dart';

class CustomHorizontalCardList extends StatefulWidget {
  final int category;

  const CustomHorizontalCardList({Key? key, required this.category}) : super(key: key);

  @override
  State<CustomHorizontalCardList> createState() => _CustomHorizontalCardListState();
}

class _CustomHorizontalCardListState extends State<CustomHorizontalCardList> {
  late Future<dynamic> _future;
  List<dynamic>? _allNovelList = [];
  late String _listTitle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = getAllNovelList();
  }

  Future getAllNovelList() async {
    await SpringNovelApi().allNovelList().then((novelList) {
      setState(() {
        _allNovelList = novelList;
      });
    });
  }
  Widget buildCardList(BuildContext context){
    Size _size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(_size.width * 0.03, 0, _size.width * 0.03, 0),
      child: ListView.builder(
          itemCount: (_allNovelList!.length > 15)
              ? 15
              : _allNovelList?.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return CustomHorizontalCard(
                novel: _allNovelList?[index],
                index: index
            );
          }),
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
