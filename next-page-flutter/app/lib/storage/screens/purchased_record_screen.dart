import 'package:flutter/material.dart';

import '../widgets/sliver_header_delegate.dart';

class PurchaseRecoreScreen extends StatefulWidget {
  const PurchaseRecoreScreen({Key? key}) : super(key: key);

  @override
  State<PurchaseRecoreScreen> createState() => _PurchaseRecoreScreenState();
}

class _PurchaseRecoreScreenState extends State<PurchaseRecoreScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('구매기록'),
    );
  }

}
