import 'package:flutter/material.dart';

class EpisodePanelWidget extends StatelessWidget {

  final ScrollController controller;

  const EpisodePanelWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8),
      controller: controller,
      children: [
        Text(';dfadsfasdfdsfasdfadsfsd')
      ],
    );
  }
}
