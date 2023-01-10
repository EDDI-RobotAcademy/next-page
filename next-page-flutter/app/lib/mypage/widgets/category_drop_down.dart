import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utility/providers/category_provider.dart';

class CategoryDropDown extends StatefulWidget {
  const CategoryDropDown({Key? key, required this.categoryList}) : super(key: key);
  final List<String> categoryList;


  @override
  State<CategoryDropDown> createState() => _CategoryDropDownBtnState();
}

class _CategoryDropDownBtnState extends State<CategoryDropDown> {
  String? dropdownValue;
  late CategoryProvider _categoryProvider;

  @override
  void initState() {
    _categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return DropdownButton<String>(
      value: dropdownValue,
      hint: Text('카테고리 선택'),
      elevation: 0,
      isExpanded: true,
      style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold, fontSize: 15),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
          debugPrint(dropdownValue);
        });
        _categoryProvider.categorySelected(dropdownValue!);
      },
      items: widget.categoryList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}