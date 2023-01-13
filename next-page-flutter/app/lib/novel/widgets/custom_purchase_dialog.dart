import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_theme.dart';
import '../../point/screens/point_charge_screen.dart';
import '../api/novel_requests.dart';
import '../api/spring_novel_api.dart';
import '../screens/scroll_novel_viewer_screen.dart';

class CustomPurchaseDialog extends StatelessWidget {
  const CustomPurchaseDialog(
      {Key? key, required this.point, required this.novelTitle, required this.episode, required this.purchasePoint, required this.memberId, required this.novelId, required this.routeIndex, required this.author, required this.publisher})
      : super(key: key);

  final int point;
  final String novelTitle;
  final dynamic episode;
  final int purchasePoint;
  final int memberId;
  final int novelId;
  final int routeIndex;
  final String author;
  final String publisher;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: EdgeInsets.only(top: 10.0),
      content: Container(
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: size.height * 0.02),
            Padding(
                padding: EdgeInsets.only(left: 30.0, right: 30.0),
                child: Row(
                  children: [
                    SizedBox(width: size.width * 0.18,),
                    //포인트 이미지 asset
                    Container(
                        width: size.width * 0.05,
                        child: Image.asset(
                            'assets/images/coin_image_asset.png')),
                    //해당 소설의 에피소드 구매 가격
                    Text(' ${purchasePoint}포인트', textAlign: TextAlign.center,),
                  ],
                )
            ),
            SizedBox(height: size.height * 0.01),
            //구매하려는 소설의 제목과 해당 회차
            Text('${novelTitle} ${episode['episodeNumber']}화',
              textAlign: TextAlign.center, style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.05
              ),),
            SizedBox(height: size.height * 0.005),
            const Text('구매하시겠습니까?', textAlign: TextAlign.center),
            SizedBox(height: size.height * 0.01),
            Divider(thickness: size.height * 0.001,),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    //클릭시 구매 진행
                    child: InkWell(
                        child: Container(
                          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(32.0)),
                          ),
                          child: Text(
                            "소장",
                            style: TextStyle(color: AppTheme.pointColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () {
                          (point > purchasePoint) ?
                          SpringNovelApi().purchaseEpisode(
                              PurchaseEpisodeRequest(
                                  novelId, memberId, episode['id'])
                          ).then((_bool) {
                            print(_bool);
                            (_bool!)
                                ?
                            Get.off(()=> ScrollNovelViewerScreen(
                              appBarTitle: novelTitle,
                              id: novelId,
                              routeIndex: routeIndex,
                              text: episode['text'],
                              episodeTitle: episode['episodeTitle'],
                              author: author,
                              episodeInfo: episode,
                              publisher: publisher,
                              purchasePoint: purchasePoint,
                            ))
                                :Get.back();
                          })
                              : Get.off(()=> PointChargeScreen(fromWhere: 0,));
                        }
                    ),),
                  Expanded(
                    //클릭시 취소, dialog 꺼짐
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(32.0)),
                        ),
                        child: Text(
                          "취소",
                          style: TextStyle(color: AppTheme.pointColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ),
                ]
            ),
          ],
        ),
      ),
    );
  }
}