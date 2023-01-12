import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../home/home_screen.dart';
import '../mypage/screens/mypage_screen.dart';
import '../novelCategory/screens/novel_screen.dart';
import '../search/screen/search_screen.dart';
import '../storage_screen.dart';

class CustomBottomAppbar extends StatefulWidget {
  final int routeIndex;

  const CustomBottomAppbar({Key? key, required this.routeIndex}) : super(key: key);

  @override
  State<CustomBottomAppbar> createState() => _CustomBottomAppbarState();
}

class _CustomBottomAppbarState extends State<CustomBottomAppbar> {
  int _selectedIndex = 0;


  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const NovelScreen(),
    const SearchScreen(),
    const StorageScreen(),
    const MypageScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _selectedIndex = widget.routeIndex;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 30,
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.book,
              size: 30,
            ),
            label: '소설',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.search,
              size: 30,
            ),
            label: '검색',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.folder_open,
              size: 30,
            ),
            label: '보관함',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline_outlined,
              size: 30,
            ),
            label: '마이',
          ),
        ],
        currentIndex: _selectedIndex,
        fixedColor: AppTheme.pointColor,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}