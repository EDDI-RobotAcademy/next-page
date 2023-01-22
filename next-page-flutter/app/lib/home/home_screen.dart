import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_theme.dart';
import '../member/screens/sign_in_screen.dart';
import '../novel/api/novel_responses.dart';
import '../point/screens/point_charge_screen.dart';
import '../widgets/link_banner_box.dart';
import 'widgets/custom_new_card_list.dart';
import 'widgets/custom_carousel.dart';
import 'widgets/custom_hot_card_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _loginState = false;
  List<dynamic>? _tmpNovelList;

  @override
  void initState() {
    _asyncMethod();
    super.initState();
  }

  void _asyncMethod() async {
    var prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');

    if (userToken != null) {
      setState(() {
        _loginState = true;
      });
    } else {
      setState(() {
        _loginState = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<List<NovelListResponse>>(context);
    Size _size = MediaQuery.of(context).size;
    provider.isEmpty ? print('전체 리스트 프로바이더 소환중') : _tmpNovelList = provider;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NEXT PAGE',
          style: TextStyle(
              color: AppTheme.pointColor,
              fontWeight: FontWeight.bold,
              fontSize: _size.width * 0.065),
        ),
        actions: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  _loginState
                      ? Get.to(() => const PointChargeScreen(
                            fromWhere: 1,
                          ))
                      : Get.to(() => const SignInScreen(
                          fromWhere: 0, novel: null, routeIndex: 0));
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
      ),
      body: provider.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Container(
              width: double.infinity,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const CustomCarousel(),
                    SizedBox(
                      height: _size.height * 0.04,
                    ),
                    CustomNewCardList(
                      newList: _tmpNovelList!,
                    ),
                    SizedBox(
                      height: _size.height * 0.04,
                    ),
                    const LinkBannerBox(),
                    SizedBox(
                      height: _size.height * 0.04,
                    ),
                    CustomHotCardList(),
                  ],
                ),
              ),
            ),
    );
  }
}
