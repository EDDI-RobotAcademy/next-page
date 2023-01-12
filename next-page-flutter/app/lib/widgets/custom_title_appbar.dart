import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_theme.dart';
import '../point/screens/point_charge_screen.dart';


AppBar customTitleAppbar(context, String title, int route) {
  return AppBar(
    backgroundColor: Colors.white,
    centerTitle: true,
    elevation: 0.0,
    actions: [
      (route < 5)?
      Row(
        children: [
          InkWell(
            onTap: (){
              Get.to(() => PointChargeScreen(fromWhere: route,));
            },
            child: Container(
                width: MediaQuery.of(context).size.width * 0.07,
                child: Image.asset('assets/images/coin_image_asset.png')),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.03,)
        ],
      )
          : Container()
    ],
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
