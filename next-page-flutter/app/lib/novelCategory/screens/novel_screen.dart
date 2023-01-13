import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../point/screens/point_charge_screen.dart';
import 'all_category_screen.dart';
import '../../app_theme.dart';


class NovelScreen extends StatefulWidget {
  const NovelScreen({Key? key}) : super(key: key);

  @override
  State<NovelScreen> createState() => _NovelScreenState();
}

class _NovelScreenState extends State<NovelScreen>
    with TickerProviderStateMixin {
  late TabController controller;
  List<String> dropdownList = ['최신순', '인기순'];
  String selectedDropdown = '최신순';
  int _allCategory = 0;
  int _fantasyCategory = 1;
  int _martialArtsCategory = 2;
  int _romanceCategory = 3;
  int _modernFantasyCategory = 4;
  int _blCategory = 5;

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 6);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '소설',
          style: TextStyle(
              color: AppTheme.pointColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => PointChargeScreen(fromWhere: 1,));
                },
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.07,
                    child: Image.asset('assets/images/coin_image_asset.png')),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              )
            ],
          )
        ],
        elevation: 0.5,
        backgroundColor: Colors.white,
        bottom: TabBar(
          isScrollable: true,
          controller: controller,
          labelColor: Colors.black,
          tabs: <Tab>[
            Tab(text: '전체'),
            Tab(text: '판타지'),
            Tab(text: '무협'),
            Tab(text: '로맨스'),
            Tab(text: '현대판타지'),
            Tab(text: 'BL'),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          AllCategoryScreen(
            category: _allCategory),
          AllCategoryScreen(
              category: _fantasyCategory),
          AllCategoryScreen(
              category: _martialArtsCategory),
          AllCategoryScreen(
              category: _romanceCategory),
          AllCategoryScreen(
              category: _modernFantasyCategory),
          AllCategoryScreen(
              category: _blCategory),
                ],
              ),
            );
  }
}
