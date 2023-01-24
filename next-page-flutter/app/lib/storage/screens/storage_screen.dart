import 'package:flutter/material.dart';
import '../../app_theme.dart';
import '../widgets/sliver_header_delegate.dart';
import 'favorite_screen.dart';
import 'purchased_record_screen.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({Key? key}) : super(key: key);

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen>
    with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  PageController pageController = PageController(initialPage: 0);

  final double sliverMinHeight = 80.0, sliverMaxHeight = 140.0;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: headerSliverBuilder,
        body: Container(
          margin: EdgeInsets.only(top: _size.height * 0.1),
          child: mainPageView(),
        ),
      ),
    );
  }

  List<Widget> headerSliverBuilder(
      BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: SliverPersistentHeader(
          pinned: true,
          delegate: SliverHeaderDelegateCS(
            minHeight: MediaQuery.of(context).size.height * 0.1,
            maxHeight: MediaQuery.of(context).size.height * 0.3,
            minChild: minTopChild(),
            maxChild: topChild(),
          ),
        ),
      ),
    ];
  }

  Widget minTopChild() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: Text(
              "보관함",
              style: TextStyle(
                color: AppTheme.pointColor,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.06,
              ),
            ),
          ),
        ),
        pageButtonLayout(),
      ],
    );
  }

  Widget topChild() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            child: Image.asset('assets/images/logo/logo2.png')
          ),
        ),
        pageButtonLayout(),
      ],
    );
  }

  Widget pageButtonLayout() {
    return SizedBox(
      height: sliverMinHeight / 2,
      child: Row(
        children: <Widget>[
          Expanded(child: pageButton("관심", 0)),
          Expanded(child: pageButton("구매기록", 1)),
        ],
      ),
    );
  }

  Widget pageButton(String title, int page) {
    final fontColor = pageIndex == page ? Colors.black : Colors.grey;
    final lineColor =
        pageIndex == page ? AppTheme.pointColor : Color(0xFFF1F1F1);

    return InkWell(
      splashColor: AppTheme.pointColor,
      onTap: () => pageBtnOnTap(page),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                    color: fontColor,
                    fontSize: MediaQuery.of(context).size.width * 0.04),
              ),
            ),
          ),
          Container(
            height: 1,
            color: lineColor,
          ),
        ],
      ),
    );
  }

  pageBtnOnTap(int page) {
    setState(() {
      pageIndex = page;
      pageController.animateToPage(pageIndex,
          duration: Duration(milliseconds: 700), curve: Curves.easeOutCirc);
    });
  }

  Widget mainPageView() {
    return PageView(
      controller: pageController,
      children: <Widget>[
        pageItem(FavoriteScreen()),
        pageItem(PurchaseRecoreScreen()),
      ],
      onPageChanged: (index) => setState(() => pageIndex = index),
    );
  }

  Widget pageItem(Widget child) {
    double statusHeight = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height;
    double minHeight = height - statusHeight - sliverMinHeight;

    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        constraints: BoxConstraints(minHeight: minHeight),
        child: child,
      ),
    );
  }
}
