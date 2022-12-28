import 'package:flutter/material.dart';
import '../app_theme.dart';


AppBar customTitleAppbar(context, String title) {
  return AppBar(
    backgroundColor: Colors.white,
    centerTitle: true,
    elevation: 0.0,
    title: Text(
      title,
      style: TextStyle(
          color: AppTheme.pointColor,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.width * 0.06),
    ),
    iconTheme: const IconThemeData(color: Colors.grey),
  );
}
