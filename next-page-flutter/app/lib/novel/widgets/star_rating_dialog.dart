import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../api/novel_requests.dart';
import '../api/spring_novel_api.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StarRatingDialog extends StatefulWidget {
  final int memberId;
  final int novelId;
  final int routeIndex;

  const StarRatingDialog(
      {Key? key, required this.memberId, required this.novelId, required this.routeIndex})
      : super(key: key);

  @override
  State<StarRatingDialog> createState() => _StarRatingDialogState();
}

class _StarRatingDialogState extends State<StarRatingDialog> {
  int _result = 10;
  final int _maxRating = 10;
  String _dialogMsg = '';
  bool _isModify = false;

  void _counter(double rating) {
    setState(() {
      _result = (rating * 2).toInt();
    });
  }

  void _checkAndChange(int value) {
    setState(() {
      _result = value;
      _dialogMsg = '별점 수정하기';
      _isModify = true;
    });
  }

  @override
  void initState() {
    checkStarRatingRecord();
    super.initState();
  }


  Future checkStarRatingRecord() async {
    await SpringNovelApi().checkMyStarRating(
        CheckMyStarRatingRequest(widget.novelId, widget.memberId)).
    then((value) {
      setState(() {
        value == 0 ?
        _dialogMsg = '별점 남기기'
            : _checkAndChange(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(_dialogMsg),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RatingBar.builder(
            initialRating: _result != null ? _result! / 2 : 5,
            minRating: 0.5,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: MediaQuery
                .of(context)
                .size
                .width * 0.05,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) =>
            const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              _counter(rating);
              print(_result);
            },
          ),
          _result != null
              ? Text(
            _result.toString(),
            style: TextStyle(fontWeight: FontWeight.bold),
          )
              : Text(
            '$_maxRating',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '좌우로 드래그하세요.',
            style: TextStyle(color: Colors.grey[700]),
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text("취소"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text("확인"),
          onPressed: () {
            _isModify ?
            SpringNovelApi()
                .requestModifyStarRating(
                AddStarRatingRequest(widget.novelId, widget.memberId, _result))
                .then((value) {
             /* value ?
              _successResult('별점 수정 성공')
                  : _failResult('별점 수정 실패');*/
            })
                : SpringNovelApi()
                .requestAddStarRating(AddStarRatingRequest(
                widget.novelId, widget.memberId, _result!))
                .then((value) {
              /*value ?
              _successResult('별점 주기 성공')
                  : _failResult('별점 주기 실패');*/
            });
          },
        ),
      ],
    );
  }

  /*void _successResult(String toastMsg) {
    Get.back();
    Fluttertoast.showToast(
        msg: toastMsg,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1
    );
  }

  void _failResult(String toastMsg) {
    Fluttertoast.showToast(
        msg: toastMsg,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1
    );
  }*/
}

