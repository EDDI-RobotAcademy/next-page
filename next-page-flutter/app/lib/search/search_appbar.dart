
import 'package:app/search/screen/search_screen.dart';
import 'package:flutter/material.dart';

import '../utility/toast_methods.dart';

class SearchAppBar extends StatefulWidget with PreferredSizeWidget {
  const SearchAppBar({Key? key, required this.controller, required this.focusNode}) : super(key: key);
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarState extends State<SearchAppBar>{

  @override
  Widget build(BuildContext context) {
    SearchScreenState? searchScreen = context.findAncestorStateOfType<SearchScreenState>();

    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0.0,
      iconTheme: const IconThemeData(color: Colors.grey),
      title: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
            hintText: '작품 또는 작가 검색',
            prefixIcon: Icon(Icons.search),
            suffixIcon: IconButton(
              onPressed: () {
                widget.controller.clear();
              },
              icon: Icon(Icons.clear),)
        ),
        autofocus: true,
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (value) {
          if(value.isEmpty) {
            showToast('검색어를 입력해주세요!');
          } else {
            setState(() {
              print("onSubmitted!");
              searchScreen?.submitted = true;
            });
          }
        },
      ),
    );
  }
}