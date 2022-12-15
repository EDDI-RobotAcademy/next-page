import 'package:app/home_screen.dart';
import 'package:app/member/screens/sign_in_screen.dart';
import 'package:app/member/screens/sign_up_screen.dart';

import 'package:app/member/utility/user_data_provider.dart';
import 'package:app/point/screens/point_charge_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'member/screens/sign_in_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => UserDataProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              appBarTheme: const AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle.dark
              )
          ),
          home: HomeScreen(),
          routes: {
            "/sign-in": (context) => const SignInScreen(),
            "/sign-up": (context) => const SignUpScreen(),
          }
      )
    );
  }
}