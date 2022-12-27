import 'package:flutter/material.dart';

import 'comment_text_form.dart';

class CommentListForm extends StatefulWidget {
  const CommentListForm({Key? key}) : super(key: key);

  @override
  State<CommentListForm> createState() => _CommentListFormState();
}

class _CommentListFormState extends State<CommentListForm> {
  int _current = 0;
  bool _onModify = false;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(15,0,15,25),
      child: Column(
        children: <Widget>[
          SizedBox(height: size.height * 0.02,),
          Expanded(
              child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: size.height * 0.18,
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 5, 8),
                            child: Row(
                              children: [
                                Text('3424234', style: TextStyle(
                                    fontSize: size.width * 0.035
                                ),),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                ),
                                Text('날짜', style: TextStyle(
                                    fontSize: size.width * 0.0315
                                ),),
                                Spacer(flex: 1),
                                (true)?
                                Row(
                                  children: [
                                    TextButton(onPressed: (){
                                      print('수정요청');
                                      setState(() {
                                        _current = index;
                                        _onModify = true;
                                      });
                                    }, child: Text("수정",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: size.width * 0.033
                                        ))),
                                    TextButton(onPressed: (){
                                      print("삭제요청");
                                    },
                                        child: Text(
                                            "삭제",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: size.width * 0.033))
                                    )
                                  ],
                                )
                                    :Text("")
                              ],
                            ),
                          ),
                          //본문 내용
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Text('댓글내용글자수제한테스트아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아댓글내용글자수제한테스트아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아',
                              style: TextStyle(
                                  fontSize: size.width * 0.033
                              ),),
                          ),
                          Container()
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(
                    color: Colors.black,
                  ),
                  itemCount: 10)),
          Divider(
            thickness: 1,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: CommentTextForm(),
            // Second child is button
          ),
        ],
      ),
    );
  }
}
