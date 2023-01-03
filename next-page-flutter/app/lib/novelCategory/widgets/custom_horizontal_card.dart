import 'package:flutter/material.dart';

import '../../novel/screens/novel_detail_screen.dart';

class CustomHorizontalCard extends StatefulWidget {
  final dynamic novel;
  final int index;

  const CustomHorizontalCard({Key? key, required this.novel, required this.index}) : super(key: key);

  @override
  State<CustomHorizontalCard> createState() => _CustomHorizontalCardState();
}

class _CustomHorizontalCardState extends State<CustomHorizontalCard> {
  @override
  Widget build(BuildContext context) {
    String _path = 'assets/images/thumbnail/${widget.novel.coverImage['reName']}';
    Size _size = MediaQuery.of(context).size;
    return Card(
        child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NovelDetailScreen(
                      id: widget.novel.id,
                      routeIndex: 1,
                    )),
              );
            },
            child: Card(
                    elevation: 0.0,
                    child: Wrap(children: [
                      Container(
                        //color: Colors.yellow,
                        height: _size.height * 0.12,
                        width: _size.width * 0.9,
                        child: Row(
                          children: [
                            Container(
                              color: Colors.green,
                              width: _size.width * 0.2,
                              height: _size.height * 0.12,
                              child: Image.asset(
                                _path,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(width: _size.width * 0.05,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: _size.height * 0.02),
                                Text('${widget.index+1}',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: _size.height * 0.022
                                ),),
                                Text(widget.novel.title, style: TextStyle(
                                  fontSize: _size.height *0.017,
                                  fontWeight: FontWeight.bold
                                ),),
                                Text(widget.novel.author, style: TextStyle(
                                  fontSize: _size.height * 0.015
                                ),),
                              ],
                            )
                          ],
                        ),
                      ),
                    ]))));
  }
}
