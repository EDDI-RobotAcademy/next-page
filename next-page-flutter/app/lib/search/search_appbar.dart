
import 'package:flutter/material.dart';

AppBar searchAppbar(TextEditingController controller, FocusNode focusNode) {

  return AppBar(
    backgroundColor: Colors.white,
    centerTitle: true,
    elevation: 0.0,
    iconTheme: const IconThemeData(color: Colors.grey),
    title: TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: '작품 또는 작가 검색',
          prefixIcon: Icon(Icons.search),
          suffixIcon: IconButton(
            onPressed: () {
              controller.clear();
            },
            icon: Icon(Icons.clear),)
      ),
      autofocus: true,
      focusNode: focusNode,
      textInputAction: TextInputAction.search,
      ),
  );
}