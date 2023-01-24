import 'package:flutter/material.dart';
import '../api/spring_pedometer_api.dart';

class CoinImageButton extends StatefulWidget {
  final bool isTaken;
  final int memberId;
  final bool loginState;
  final int steps;

  const CoinImageButton(
      {Key? key,
      required this.isTaken,
      required this.memberId,
      required this.loginState, required this.steps})
      : super(key: key);

  @override
  State<CoinImageButton> createState() => _CoinImageButtonState();
}

class _CoinImageButtonState extends State<CoinImageButton> {
  bool? _isTaken;
  late int paymentId;

  @override
  void initState() {
    setState(() {
      _isTaken = widget.isTaken;
    });
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    paymentId = DateTime.now().millisecondsSinceEpoch;
    return widget.steps >= 10000 && widget.loginState && _isTaken != true
        ? Positioned(
        bottom: _size.height * 0.37,
        right: _size.width * 0.4,
        child: InkWell(
          onTap: () async {
            await SpringPedometerApi().getPointByPedometer(widget.memberId).then((value) {
              if(value){
                setState(() {
                  _isTaken = true;
                });
                 //포인트 더해주는 로직 추가
              }
            });
          },
          child: Container(
              width: _size.width * 0.2,
              child: Image.asset(
                  'assets/images/coin_image_asset.png')),
        ))
        : widget.steps >= 10000 && _isTaken == true?
        Positioned(
          bottom: _size.height * 0.25,
            right: _size.width * 0.25,
            child: Text('오늘은 이미 포인트를 수령했습니다.'))
        :Text('');
  }
}
