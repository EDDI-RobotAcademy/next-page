import 'package:flutter/cupertino.dart';

class TmpMyScreen extends StatefulWidget {
  const TmpMyScreen({Key? key}) : super(key: key);

  @override
  State<TmpMyScreen> createState() => _TmpMyScreenState();
}

class _TmpMyScreenState extends State<TmpMyScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('임시 페이지')
    );
  }
}
