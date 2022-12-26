import 'package:flutter/material.dart';

import 'custom_vertical_card.dart';
import 'model/tmp_novel_model.dart';

class CustomCardList extends StatefulWidget {
  const CustomCardList({Key? key}) : super(key: key);

  @override
  State<CustomCardList> createState() => _CustomCardListState();
}

class _CustomCardListState extends State<CustomCardList> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.03, 0, size.width * 0.03, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'New 연재 작품',
            style: TextStyle(
                fontSize: size.width * 0.05, fontWeight: FontWeight.bold),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: size.height * 0.28,
              child: ListView.builder(
                  itemCount: (TmpNovelModel.novelList.length > 15)
                      ? 15
                      : TmpNovelModel.novelList.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomVerticalCard(
                        novel: TmpNovelModel.novelList[index]);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
