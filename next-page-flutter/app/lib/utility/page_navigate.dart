import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void popPopPush(BuildContext context, Widget screen) {
  Navigator.pop(context);
  Navigator.pop(context);
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => screen));
}

void popPopPop(){
  Get.back();
  Get.back();
  Get.back();
}