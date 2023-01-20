import 'package:flutter/material.dart';
import 'custom_vertical_card.dart';


class CustomHotCardList extends StatefulWidget {
  final List<dynamic> hotList;

  const CustomHotCardList({Key? key, required this.hotList}) : super(key: key);

  @override
  State<CustomHotCardList> createState() => _CustomCardListState();
}

class _CustomCardListState extends State<CustomHotCardList> {
  List<dynamic>? _hotList;


  @override
  void initState() {
    setState(() {
      _hotList = widget.hotList;
      _hotList!.sort((a,b) => b.viewCount.compareTo(a.viewCount));
    });
    super.initState();
  }

Widget buildCardList(BuildContext context){
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
          SizedBox(height: size.height * 0.01,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: size.height * 0.28,
              child: ListView.builder(
                  itemCount: (_hotList!.length > 15)
                      ? 15
                      : _hotList!.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomVerticalCard(
                        novel: _hotList![index]);
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
