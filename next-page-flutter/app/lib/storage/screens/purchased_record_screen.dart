import 'package:flutter/material.dart';

class PurchaseRecordScreen extends StatefulWidget {
  const PurchaseRecordScreen({Key? key}) : super(key: key);

  @override
  State<PurchaseRecordScreen> createState() => _PurchaseRecordScreenState();
}

class _PurchaseRecordScreenState extends State<PurchaseRecordScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('구매기록'),
    );
  }

}
