import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../app_theme.dart';
import '../../novel/screens/novel_detail_screen.dart';

class CustomHorizontalCard extends StatefulWidget {
  final dynamic novel;
  final int index;
  final String sort;

  const CustomHorizontalCard(
      {Key? key, required this.novel, required this.index, required this.sort})
      : super(key: key);

  @override
  State<CustomHorizontalCard> createState() => _CustomHorizontalCardState();
}

class _CustomHorizontalCardState extends State<CustomHorizontalCard> {
  var now = DateTime.now();
  var format = 'yyyy-MM-dd';
  String todayString = '';
  String todayAfter1String = '';
  String todayAfter2String = '';

  @override
  void initState() {
    todayString = DateFormat(format).format(now).toString();
    todayAfter1String =
        DateFormat(format).format(now.add(Duration(days: 1))).toString();
    todayAfter2String =
        DateFormat(format).format(now.add(Duration(days: 2))).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String _path =
        'assets/images/thumbnail/${widget.novel.coverImage['reName']}';
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
                        Stack(children: [
                          Container(
                            color: Colors.green,
                            width: _size.width * 0.2,
                            height: _size.height * 0.12,
                            child: Image.asset(
                              _path,
                              fit: BoxFit.fill,
                            ),
                          ),
                          widget.novel.createdDate == todayString ||
                                  widget.novel.createdDate ==
                                      todayAfter1String ||
                                  widget.novel.createdDate == todayAfter2String
                              ? Container(
                                  color: Colors.black,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        _size.width * 0.01,
                                        0,
                                        _size.width * 0.01,
                                        0),
                                    child: Text(
                                      'new',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              : Text(''),
                        ]),
                        SizedBox(
                          width: _size.width * 0.05,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: _size.height * 0.02),
                            widget.sort == '인기순'
                                ? Text(
                                    '${widget.index + 1}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: _size.height * 0.022),
                                  )
                                : Text(''),
                            Text(
                              widget.novel.title,
                              style: TextStyle(
                                  fontSize: _size.height * 0.017,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.novel.author,
                              style: TextStyle(fontSize: _size.height * 0.015),
                            ),
                            SizedBox(height: _size.height * 0.005,),
                            Container(
                              child: Row(
                                children: [
                                  Wrap(children: [
                                    Icon(
                                      Icons.star,
                                      color: AppTheme.pointColor,
                                    ),
                                    widget.novel.ratingCount > 0
                                        ? Padding(
                                            padding: EdgeInsets.only(
                                                top: _size.height * 0.005),
                                            child: Text(
                                                (widget.novel.totalStarRating /
                                                        widget.novel.ratingCount)
                                                    .toStringAsFixed(1)),
                                          )
                                        : Padding(
                                            padding: EdgeInsets.only(
                                                top: _size.height * 0.005),
                                            child: Text('0.0'),
                                          )
                                  ]),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(_size.width * 0.04,_size.height * 0.003,0, 0),
                                    child: Text(widget.novel.viewCount.toString(),style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ]))));
  }
}
