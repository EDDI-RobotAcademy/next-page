import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_horizontal_card_list.dart';

class AllCategoryScreen extends StatefulWidget {
  final int category;

  const AllCategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  String value = "최신순";

  @override
  Widget build(BuildContext context) {
    final actionSheet = CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            setState(() {
              value = "최신순";
            });
          },
          child: const Text("최신순"),
        ),
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            setState(() {
              value = "인기순";
            });
          },
          child: const Text("인기순"),
        )
      ],
    );

    return Scaffold(
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
                      value,
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
                      context: context, builder: (context) => actionSheet);
                })
          ]),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
        ],
      ),
      Expanded(
          child: CustomHorizontalCardList(
            category: widget.category,
          )
      )
    ]));
  }
}
