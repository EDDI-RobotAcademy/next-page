import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:app/member/api/spring_member_api.dart';
import 'package:app/point/api/request_forms.dart';
import 'package:app/point/api/spring_point_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_theme.dart';
import '../../widgets/custom_bottom_appbar.dart';


class PointChargeScreen extends StatefulWidget {
  const PointChargeScreen({Key? key, required this.fromWhere}) : super(key: key);
  final int fromWhere;

  @override
  State<PointChargeScreen> createState() => _PointChargeScreenState();
}

class _PointChargeScreenState extends State<PointChargeScreen> {
  final int myIdx = 4;

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products = <ProductDetails>[];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;

  late int currentPoint;
  late int memberId;
  late int paymentId;
  late int amount;
  late int purchasePoint;

  static const Set<String> _ids = <String>{'500p', '1000p', '3000p', '5000p', '10000p', '30000p', '50000p', '100000p'};

  @override
  void initState() {
    _setUserData();

    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    //결제 관련 동작 감지
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
          _listenToPurchaseUpdated(purchaseDetailsList);
        }, onDone: () {
          _subscription.cancel();
        }, onError: (Object error) {
          debugPrint("_subscription 초기화 실패");
        });
    initStoreInfo();
  }

  void _setUserData() async {
    var prefs = await SharedPreferences.getInstance();

    setState(() async {
      memberId = prefs.getInt('userId')!;
      currentPoint = prefs.getInt('point')!;
    });

    prefs.setInt('point', currentPoint);
    print("prefs 포인트: " + prefs.getInt('point').toString());
  }

  Future<void> initStoreInfo() async {
    // 인앱 구매가 가능한지 체크
    debugPrint("initStoreInfo()");
    final bool isAvailable = await _inAppPurchase.isAvailable();

    if (!isAvailable) {
      debugPrint("인앱결제 불가능!");
    }

    //플랫폼이 ios면
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }
    // 인앱 상품 로드
    final ProductDetailsResponse productDetailResponse =
    await _inAppPurchase.queryProductDetails(_ids);

    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      // 포인트 상품을 가격순으로 오름차순 정렬
      _products.sort((a, b) => a.rawPrice.compareTo(b.rawPrice));
      _purchasePending = false;
      _loading = false;
    });
  }

  // 인앱결제 업데이트 처리
  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      // 인앱결제가 처리중일때
      if (purchaseDetails.status == PurchaseStatus.pending) {
        setState(() { _purchasePending = true; });
      } else {
        // 인앱 결제 에러
        if (purchaseDetails.status == PurchaseStatus.error) {
          debugPrint("구매 실패!");
          setState(() { _purchasePending = false; });
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          // 인앱 결제 성공 시 스프링 서버에 포인트 충전 요청
          final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            debugPrint("포인트 충전 완료!");
            // 포인트 충전 후 유저 포인트 데이터 spring 서버에 요청
            int chargedPoint = await SpringMemberApi().lookUpUserPoint(memberId);
            var prefs =  await SharedPreferences.getInstance();
           prefs.setInt('point', chargedPoint);
            setState(() {
              currentPoint = prefs.getInt('point')!;
              _loading = true;
            });
            // debugPrint(currentPoint.toString());
            Future.delayed(Duration(milliseconds: 200), () {
              setState(() => _loading = false );});
          } else {
            debugPrint("invalid purchase!");
            return;
          }
        }
        if (Platform.isAndroid) {
            final InAppPurchaseAndroidPlatformAddition androidAddition =
            _inAppPurchase.getPlatformAddition<
                InAppPurchaseAndroidPlatformAddition>();
            await androidAddition.consumePurchase(purchaseDetails);
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }
  // 스프링에 포인트 충전 요청
  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    paymentId = DateTime.now().millisecondsSinceEpoch;
     var res;
     res = await SpringPointApi().requestPointCharge(
         PointChargeForm(member_id: memberId, payment_id: paymentId, amount: amount, point: purchasePoint));
     return res;
  }

  @override
  void dispose() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(currentPoint);

    final List<Widget> stack = <Widget>[];
      stack.add(
        ListView(
          children: <Widget>[
            _buildProductList(),
          ],
        ),
      );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("포인트 충전"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              // 마이페이지에서 포인트 충전 페이지로 이동힌 경우
              // 뒤로가기 버튼을 누르면 충전 후 포인트 정보가 적용되게 함.
              // pushAndRemoveUntil로 마이페이지 앱바에 뒤로가기 생기는 것 방지
              if(widget.fromWhere == myIdx) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            CustomBottomAppbar(routeIndex: myIdx,)),
                        (route) => false);
              } else {
                Navigator.pop(context);
              }
            }
        )
      ),
      body: Stack(
        children: stack,
      ),
    );
  }

  Card _buildProductList() {
    Size size = MediaQuery.of(context).size;

    if (_loading) {
      return const Card(
          child: ListTile(
              leading: CircularProgressIndicator(),
              title: Text('Fetching products...')));
    }
    // 인앱 결제 사용 불가능이면 빈 카드
    if (!_isAvailable) {
      return const Card();
    }

    final List<Widget> productList = <Widget>[];

    ListTile userPoint =  ListTile(
        title: Text('현재 보유 포인트: $currentPoint p',
            style: TextStyle(fontSize: 20)));

    productList.addAll(_products.map(
          (ProductDetails productDetails) {
        var title = productDetails.title;
        var price = productDetails.price;
        return Column( children: [
          Divider(),
          ListTile(
            title: Text( title.substring(0, title.indexOf('(') - 1) ),
            //가격이 표시되는 결제 버튼
            trailing: Container(
                height: size.width * 0.1,
                width: size.width * 0.25,
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: AppTheme.pointColor,
                  ),
                  onPressed: () {
                  late PurchaseParam purchaseParam;
                  // 특수기호 제거하고 int 형변환
                  amount = int.parse(price.substring(1).replaceAll(RegExp('\\D'), ""));
                  // 숫자 부분만 남기고 형변환(title이 'xxx 포인트' 형식입니다.)
                  purchasePoint = int.parse(title.substring(0, title.indexOf(' ')));
                  if (Platform.isAndroid) {
                    purchaseParam = GooglePlayPurchaseParam( productDetails: productDetails,);
                  } else {
                  purchaseParam = PurchaseParam(productDetails: productDetails,);
                  }
                  _inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
                  },
                  child: Text('${price.substring(1)}원'),
                  ),
                ),
              ),
        ],
        );
      },
    ));

    return Card(
        child: Column(
            children: <Widget>[userPoint] + productList));
  }
}

class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
