import 'package:flutter/material.dart';
import '../../novel/api/spring_novel_api.dart';
import 'custom_vertical_card.dart';

class CustomHotCardList extends StatefulWidget {
  const CustomHotCardList({Key? key}) : super(key: key);

  @override
  State<CustomHotCardList> createState() => _CustomCardListState();
}

class _CustomCardListState extends State<CustomHotCardList> {
  List<dynamic>? _hotNovelList;
  var _future;

  @override
  void initState() {
    _future = _getHotNovelList();
  }

  _getHotNovelList() async {
    _hotNovelList = await SpringNovelApi().getHotShortNovelList(15);
  }

  Widget buildCardList(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.03, 0, size.width * 0.03, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'HOT 인기 작품',
            style: TextStyle(
                fontSize: size.width * 0.05, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: size.height * 0.28,
              child: ListView.builder(
                  itemCount: (_hotNovelList!.length > 15)
                      ? 5
                      : _hotNovelList!.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomVerticalCard(novel: _hotNovelList![index]);
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
