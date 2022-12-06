import 'package:flutter/material.dart';

import '../../app_theme.dart';
import '../../model/tmp_novel_notice.dart';

class NovelNotice extends StatefulWidget {
  const NovelNotice({Key? key}) : super(key: key);

  @override
  State<NovelNotice> createState() => _NovelNoticeState();
}

class _NovelNoticeState extends State<NovelNotice> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
          child: Column(
            children: TmpNovelNotice.noticeList.map((notice){
              return noticeCardList(notice);
            }).toList(),
          ),
        )
    );
  }
  Widget noticeCardList(dynamic notice) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(19),
          bottomLeft: Radius.circular(19)
      ),
      child: Card(
        color: AppTheme.chalk,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      notice.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17
                      ),
                    ),
                    const Spacer(flex: 1,),
                    Text(notice.regDate, style: const TextStyle(
                      color: Colors.black26,
                    ),)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(notice.content),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
