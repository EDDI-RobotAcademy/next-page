import 'package:flutter/material.dart';
import '../custom_title_appbar.dart';
import 'widgets/custom_card_list.dart';
import 'widgets/custom_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: customTitleAppbar(context, 'NEXT PAGE'),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const CustomCarousel(),
              SizedBox(
                height: size.height * 0.05,
              ),
              const CustomCardList()
            ],
          ),
        ),
      ),
    );
  }
}