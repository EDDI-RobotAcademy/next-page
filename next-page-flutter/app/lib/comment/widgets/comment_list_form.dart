import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utility/providers/comment_provider.dart';
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
              child: Consumer<CommentProvider>(
                builder: (context, comment, child) {
                  return ListView.separated(
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
                                    Text(comment.episodeCommentList![index].nickName, style: TextStyle(
                                        fontSize: size.width * 0.035
                                    ),),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                    ),
                                    Text(comment.episodeCommentList![index].regDate, style: TextStyle(
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
                                        :Text("") // 원래 있던 코드인데 dead code로 인식됨.
                                  ],
                                ),
                              ),
                              //본문 내용
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Text(comment.episodeCommentList![index].comment,
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
                      itemCount: comment.episodeCommentList!.length);
                },
              )),
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
