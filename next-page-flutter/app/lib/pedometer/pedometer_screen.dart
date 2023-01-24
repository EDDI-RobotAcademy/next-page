import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../app_theme.dart';
import 'package:intl/intl.dart';

import '../member/screens/sign_in_screen.dart';
import '../widgets/custom_transparent_appbar.dart';
import 'api/pedometer_request.dart';
import 'api/spring_pedometer_api.dart';
import 'widgets/coin_image_button.dart';

class PedometerScreen extends StatefulWidget {
  @override
  _PedometerScreenState createState() => _PedometerScreenState();
}

enum AppState {
  DATA_NOT_FETCHED,
  FETCHING_DATA,
  DATA_READY,
  NO_DATA,
  AUTH_NOT_GRANTED,
  DATA_ADDED,
  DATA_NOT_ADDED,
  STEPS_READY,
}

class _PedometerScreenState extends State<PedometerScreen> {
  List<HealthDataPoint> _healthDataList = [];
  AppState _state = AppState.DATA_NOT_FETCHED;
  int _nofSteps = 10;
  double _mgdl = 10.0;
  int? _myPoint;
  bool _loginState = false;
  int? _memberId;
  var now = DateTime.now();
  var format = 'yyyy-MM-dd';
  String todayString = '';
  var f = NumberFormat.currency(locale: 'ko_KR', symbol: '');
  var _future;
  bool? _isTaken;
  bool _isLoading = true;

  // create a HealthFactory for use in the app
  HealthFactory health = HealthFactory();

  @override
  void initState() {
    todayString = DateFormat(format).format(now).toString();
    _asyncMethod();
    fetchStepData();
    _future = _checkPedometer();
    super.initState();
  }

  void _asyncMethod() async {
    var prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');

    if (userToken != null) {
      setState(() {
        _myPoint = prefs.getInt('point')!;
        _memberId = prefs.getInt('userId')!;
        _loginState = true;
      });
    } else {
      setState(() {
        _loginState = false;
      });
    }
  }

  _checkPedometer() async {
    Future.delayed(Duration(milliseconds: 1000), () {
      _isLoading = false;
      SpringPedometerApi()
          .requestCheckPedometer(CheckPedometerRequest(_memberId!, todayString))
          .then((value) {
        setState(() {
          value ? _isTaken = true : _isTaken = false;
        });
      });
    });
  }

  /// Fetch data points from the health plugin and show them in the app.
  Future fetchData() async {
    setState(() => _state = AppState.FETCHING_DATA);

    // define the types to get
    final types = [HealthDataType.ELECTROCARDIOGRAM];

    final permissions = [
      HealthDataAccess.READ,
    ];

    final now = DateTime.now();
    final yesterday = now.subtract(Duration(days: 300));
    bool requested =
        await health.requestAuthorization(types, permissions: permissions);
    print('requested: $requested');

    await Permission.activityRecognition.request();
    await Permission.location.request();

    if (requested) {
      try {
        // fetch health data
        List<HealthDataPoint> healthData =
            await health.getHealthDataFromTypes(yesterday, now, types);
        // save all the new data points (only the first 100)
        _healthDataList.addAll((healthData.length < 100)
            ? healthData
            : healthData.sublist(0, 100));
      } catch (error) {
        print("Exception in getHealthDataFromTypes: $error");
      }

      // filter out duplicates
      _healthDataList = HealthFactory.removeDuplicates(_healthDataList);

      // print the results
      _healthDataList.forEach((x) => print(x));
      print((_healthDataList.first.value as ElectrocardiogramHealthValue)
          .voltageValues);

      // update the UI to display the results
      setState(() {
        _state =
            _healthDataList.isEmpty ? AppState.NO_DATA : AppState.DATA_READY;
      });
    } else {
      print("Authorization not granted");
      setState(() => _state = AppState.DATA_NOT_FETCHED);
    }
  }

  /// Add some random health data.
  Future addData() async {
    final now = DateTime.now();
    final earlier = now.subtract(Duration(minutes: 20));

    final types = [
      HealthDataType.STEPS,
      HealthDataType.HEIGHT,
      HealthDataType.BLOOD_GLUCOSE,
      HealthDataType.WORKOUT,
    ];
    final rights = [
      HealthDataAccess.WRITE,
      HealthDataAccess.WRITE,
      HealthDataAccess.WRITE,
      HealthDataAccess.WRITE,
    ];
    final permissions = [
      HealthDataAccess.READ_WRITE,
      HealthDataAccess.READ_WRITE,
      HealthDataAccess.READ_WRITE,
      HealthDataAccess.READ_WRITE,
    ];
    bool? hasPermissions =
        await HealthFactory.hasPermissions(types, permissions: rights);
    if (hasPermissions == false) {
      await health.requestAuthorization(types, permissions: permissions);
    }

    _nofSteps = Random().nextInt(10);
    bool success = await health.writeHealthData(
        _nofSteps.toDouble(), HealthDataType.STEPS, earlier, now);

    // Store a workout eg. running
    success &= await health.writeWorkoutData(
      HealthWorkoutActivityType.RUNNING, earlier, now,
      // The following are optional parameters
      // and the UNITS are functional on iOS ONLY!
      totalEnergyBurned: 230,
      totalEnergyBurnedUnit: HealthDataUnit.KILOCALORIE,
      totalDistance: 1234,
      totalDistanceUnit: HealthDataUnit.FOOT,
    );
    setState(() {
      _state = success ? AppState.DATA_ADDED : AppState.DATA_NOT_ADDED;
    });
  }

  /// Fetch steps from the health plugin and show them in the app.
  Future fetchStepData() async {
    int? steps;

    // get steps for today (i.e., since midnight)
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    bool requested = await health.requestAuthorization([HealthDataType.STEPS]);

    if (requested) {
      try {
        steps = await health.getTotalStepsInInterval(midnight, now);
      } catch (error) {
        print("Caught exception in getTotalStepsInInterval: $error");
      }

      print('Total number of steps: $steps');

      setState(() {
        _nofSteps = (steps == null) ? 0 : 10000;
        _state = (steps == null) ? AppState.NO_DATA : AppState.STEPS_READY;
      });
    } else {
      print("Authorization not granted - error in authorization");
      setState(() => _state = AppState.DATA_NOT_FETCHED);
    }
  }

  Widget _contentNotFetched() {
    return Center(
      child: Text('데이터를 불러올 수 없습니다.'),
    );
  }


  Widget _content() {
    if (_state == AppState.STEPS_READY) return _stepsFetched();

    return _contentNotFetched();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: customTransparentAppbar(),
      body: _loginState
          ? _isLoading
              ? Container(
                  color: Colors.white,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : FutureBuilder(
                  future: _future,
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        return Stack(
                          children: [
                            Container(
                              color: Colors.grey[200],
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: _size.height * 0.005),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(19),
                                          bottomLeft: Radius.circular(19)),
                                      child: Card(
                                        color: AppTheme.natureWhite,
                                        child: InkWell(
                                            child: Container(
                                          height: _size.height * 0.08,
                                          child: Row(children: <Widget>[
                                            SizedBox(
                                              width: _size.height * 0.02,
                                            ),
                                            Container(
                                                height: _size.height * 0.03,
                                                child: Image.asset(
                                                    'assets/images/coin_image_asset.png')),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 10, 0),
                                              child: Text(
                                                '내포인트',
                                                style: TextStyle(
                                                    fontSize:
                                                        _size.width * 0.035),
                                              ),
                                            ),
                                            Text('${f.format(_myPoint)}p',
                                                style: TextStyle(
                                                  fontSize: _size.width * 0.04,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ]),
                                        )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: _size.height * 0.005,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(9),
                                    child: Container(
                                      color: AppTheme.natureWhite,
                                      height: _size.height * 0.6,
                                      width: _size.width * 0.97,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                _size.width * 0.04,
                                                _size.height * 0.01,
                                                0,
                                                0),
                                            child: _bigNoticeTxt(_size, '만보를 걸으면')
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    _size.width * 0.04,
                                                    0,
                                                    0,
                                                    0),
                                                child: Text('300',
                                                    style: TextStyle(
                                                        fontSize:
                                                            _size.width * 0.06,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.blue)),
                                              ),
                                              _bigNoticeTxt(_size, '포인트를 받을 수 있어요')
                                            ],
                                          ),
                                          SizedBox(
                                            height: _size.height * 0.1,
                                          ),
                                          Center(
                                            child: _content(),
                                          ),
                                          SizedBox(height: _size.height * 0.05),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              _nofSteps < 2500
                                                  ?  _noticeTxt(_size, '제발 좀 나가서 걸어주세요')
                                                  : 2500 <= _nofSteps && _nofSteps < 5000
                                                      ? _noticeTxt(_size, '조금 걸으셨네요?.. 조금..')
                                                      : 5000 <= _nofSteps && _nofSteps < 7500
                                                          ?  _noticeTxt(_size, '걷는 김에 좀 더 걸어볼까요?')
                                                          : 7500 <= _nofSteps && _nofSteps < 10000
                                                              ? _noticeTxt(_size, '300포인트가 눈앞에!!')
                                                              : 10000 <= _nofSteps
                                                                  ? _noticeTxt(_size, '만보 달성!')
                                                                  : _noticeTxt(_size, '걸음수 데이터를 불러오는 중이에요.')
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            CoinImageButton(
                              steps: _nofSteps,
                              isTaken: _isTaken!,
                              memberId: _memberId!,
                              loginState: _loginState,
                            )
                          ],
                        );
                      }
                    } else {
                      return const Text("망");
                    }
                  }))
          : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('만보기는 로그인이 필요합니다.', style: TextStyle(
                    fontSize: _size.width * 0.06
                  ),),
                  SizedBox(height: _size.height * 0.03,),
                  InkWell(
                    onTap: (){
                      Get.to(() => SignInScreen(fromWhere: 0, novel: null, routeIndex: 0));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15)
                      ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text('로그인', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700]
                            ),),
                          )
                    ),
                  ),
                ],
              ),
          ),
    );
  }

  Widget _stepsFetched() {
    return TweenAnimationBuilder(
        tween: Tween(begin: 0.0, end: _nofSteps / 10000),
        duration: Duration(seconds: 2),
        builder: (context, value, child) {
          // percentage to show in Center Text
          int percentage = (value * 100).ceil();
          return Container(
            width: 200,
            height: 200,
            child: Stack(
              children: [
                ShaderMask(
                  shaderCallback: (rect) {
                    return SweepGradient(
                        startAngle: 0.0,
                        endAngle: 3.14 * 2,
                        stops: [value, value],
                        // value from Tween Animation Builder
                        // 0.0 , 0.5 , 0.5 , 1.0
                        center: Alignment.center,
                        colors: [AppTheme.pointColor, AppTheme.chalk])
                        .createShader(rect);
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 200 - 40,
                    height: 200 - 40,
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(
                              _nofSteps.toString(),
                              style: TextStyle(
                                  fontSize:
                                  MediaQuery.of(context).size.width * 0.06,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            )),
                        Center(
                          child: Text('걸음'),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget _bigNoticeTxt(Size size , String txt){
    return Text(
      txt,
      style: TextStyle(
          fontSize: size.width *
              0.05,
          fontWeight:
          FontWeight.bold),
    );
  }


  Widget _noticeTxt(Size size , String txt){
    return Text(
      txt,
      style: TextStyle(
          fontSize: size.width *
              0.05,
          fontWeight:
          FontWeight.bold),
    );
  }
}
