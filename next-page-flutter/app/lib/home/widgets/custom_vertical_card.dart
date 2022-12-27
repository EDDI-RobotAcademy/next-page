import 'package:flutter/material.dart';

import '../../novel/screens/novel_detail_screen.dart';

class CustomVerticalCard extends StatefulWidget {
  final dynamic novel;

  const CustomVerticalCard({Key? key, this.novel}) : super(key: key);

  @override
  State<CustomVerticalCard> createState() => _CustomVerticalCardState();
}

class _CustomVerticalCardState extends State<CustomVerticalCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
        child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NovelDetailScreen(
                      id: widget.novel.id,
                    )),
              );
            },
            child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Card(
                    elevation: 0.0,
                    child: Wrap(children: [
                      Image.asset(
                        widget.novel.thumbnail,
                        fit: BoxFit.cover,
                      ),
                      ListTile(
                        title: Text(
                          widget.novel.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.041,
                          ),
                        ),
                        subtitle: Text(
                          widget.novel.writer,
                          style: TextStyle(
                            fontSize: size.width * 0.035,
                          ),
                        ),
                      ),
                    ])))));
  }
}
