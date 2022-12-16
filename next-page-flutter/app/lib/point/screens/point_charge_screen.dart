import 'dart:core';

import 'package:app/member/utility/user_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../point_option.dart';

class PointChargeScreen extends StatelessWidget {
  const PointChargeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 충전할 포인트와 포인트 결제금액 옵션 리스트
    List<PointOption> pointOptions = [
      PointOption(point: 500, price: 500),
      PointOption(point: 1000, price: 1000),
      PointOption(point: 3000, price: 3000),
      PointOption(point: 5000, price: 5000),
      PointOption(point: 10000, price: 10000),
      PointOption(point: 30000, price: 30000),
      PointOption(point: 50000, price: 50000),
      PointOption(point: 100000, price: 100000),
    ];

    Size size = MediaQuery.of(context).size;
    UserDataProvider _userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
    // _userDataProvider.requestPointData();
    // requestPointData()는 스프링 서버에 유저의 포인트 정보를 요청하는 api를 넣을 예정

    return Scaffold(
          // 뒤로 가기 버튼이 있는 앱바
            appBar: AppBar(
                elevation: 0,
                title: Text("포인트 충전"),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.pop(context),
                )
            ),
            body: Padding(
                padding: EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    SizedBox(height: size.height * 0.05),
                    // 사용자의 현재 보유 포인트를 보여주는 부분
                    Text("현재 보유 포인트 : ${_userDataProvider.point} point", style: TextStyle(fontSize: 20)),
                    SizedBox(height: size.height * 0.05),
                    // 포인트 충전 옵션 리스트가 출력되는 부분
                    ListView.separated(
                        itemCount: pointOptions.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              Expanded(
                                  child: ListTile(
                                      title: Text(
                                          "${pointOptions[index].point} p"))),
                              Container(
                                  margin: EdgeInsets.all(10.0),
                                  height: size.width * 0.1,
                                  width: size.width * 0.23,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        //인앱결제 연결
                                      },
                                      child: Text("${pointOptions[index].price}원")))
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) => Divider(thickness: 1, height: 1),),
                    SizedBox(height: size.height * 0.05),
                    Text("이용안내"),
                    Text("환불 규정이 어쩌고 저쩌고,,,"),
                    Text("환불 규정이 어쩌고 저쩌고,,,"),
                    Text("환불 규정이 어쩌고 저쩌고,,,"),
                    Text("환불 규정이 어쩌고 저쩌고,,,"),
                  ],
                )
            )
        );
  }
}
