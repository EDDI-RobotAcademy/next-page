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
        DateFormat(format).format(now.subtract(Duration(days: 1))).toString();
    todayAfter2String =
        DateFormat(format).format(now.subtract(Duration(days: 2))).toString();
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
                          widget.novel.publisher == '넥스트페이지'?
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              color: Colors.black,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    _size.width * 0.01,
                                    0,
                                    _size.width * 0.01,
                                    0),
                                child: Text(
                                  '독점',
                                  style: TextStyle(color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: _size.width * 0.025),
                                ),
                              ),
                            ),
                          ):
                          Text('')
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
                              width: _size.width * 0.6,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  SizedBox(width: _size.width * 0.01,),
                                  Wrap(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0,_size.height * 0.004,0, 0),
                                        child: Text('${widget.novel.viewCount.toString()}회'
                                          ,style: TextStyle(
                                              color: Colors.grey[600]
                                          ),),
                                      ),
                                    ],
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
