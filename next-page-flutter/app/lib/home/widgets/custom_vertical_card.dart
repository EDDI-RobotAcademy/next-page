import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../novel/screens/novel_detail_screen.dart';

class CustomVerticalCard extends StatefulWidget {
  final dynamic novel;

  const CustomVerticalCard({Key? key, this.novel}) : super(key: key);

  @override
  State<CustomVerticalCard> createState() => _CustomVerticalCardState();
}

class _CustomVerticalCardState extends State<CustomVerticalCard> {
  var now = DateTime.now();
  var format = 'yyyy-MM-dd';
  String todayString = '';
  String todayAfter1String = '';
  String todayAfter2String = '';

  @override
  void initState() {
    todayString = DateFormat(format).format(now).toString();
    todayAfter1String = DateFormat(format).format(now.add(Duration(days: 1))).toString();
    todayAfter2String = DateFormat(format).format(now.add(Duration(days: 2))).toString();
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
                          routeIndex: 0,
                        )),
              );
            },
            child: Container(
                width: _size.width * 0.3,
                child: Card(
                    elevation: 0.0,
                    child: Wrap(children: [
                      //카드 이미지
                      Stack(children: [
                        Container(
                          height: _size.height * 0.175,
                          width: _size.width * 0.28,
                          child: Image.asset(
                            _path,
                            fit: BoxFit.fill,
                          ),
                        ),
                        widget.novel.createdDate == todayString || widget.novel.createdDate == todayAfter1String || widget.novel.createdDate == todayAfter2String?
                        Container(
                          color: Colors.black,
                          child: Padding(
                            padding:  EdgeInsets.fromLTRB(_size.width * 0.01,0,_size.width * 0.01,0),
                            child: Text('new', style: TextStyle(
                              color: Colors.white
                            ),),
                          ),
                        )
                            :Text('')
                      ]),
                      Divider(
                        height: _size.height * 0.001,
                        thickness: _size.height * 0.01,
                      ),
                      ListTile(
                        //소설 제목
                        title: Text(
                          widget.novel.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: _size.width * 0.035,
                          ),
                        ),
                        //소설 작가
                        subtitle: Text(
                          widget.novel.author,
                          style: TextStyle(
                            fontSize: _size.width * 0.03,
                          ),
                        ),
                      ),
                    ])))));
  }
}
