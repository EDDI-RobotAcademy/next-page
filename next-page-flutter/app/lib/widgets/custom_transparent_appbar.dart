import 'package:flutter/material.dart';

AppBar customTransparentAppbar(){
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    iconTheme: const IconThemeData(
      color: Colors.grey
    ),
  );
}