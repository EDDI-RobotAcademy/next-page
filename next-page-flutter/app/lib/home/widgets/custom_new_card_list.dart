import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../novel/api/novel_responses.dart';
import 'custom_vertical_card.dart';

class CustomNewCardList extends StatefulWidget {
  final List<dynamic> newList;

  const CustomNewCardList({Key? key, required this.newList}) : super(key: key);

  @override
  State<CustomNewCardList> createState() => _CustomNewCardListState();
}

class _CustomNewCardListState extends State<CustomNewCardList> {
  List<dynamic>? _newNovelList;

  @override
  void initState() {
    setState(() {
      _newNovelList = widget.newList;
      _newNovelList!.sort((a,b) => b.id.compareTo(a.id));
    });
    super.initState();
  }


  Widget buildCardList(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    var _novelListProvider = Provider.of<List<NovelListResponse>>(context);
    return Padding(
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
                  itemCount: (_novelListProvider!.length > 15)
                      ? 15
                      : _novelListProvider!.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomVerticalCard(
                        novel: _novelListProvider![index]);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildCardList(context);
  }
}
