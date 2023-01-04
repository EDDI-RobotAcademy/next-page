import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


import 'widgets/custom_bottom_appbar.dart';
import 'member/screens/sign_in_screen.dart';
import 'member/screens/sign_up_screen.dart';
import 'member/utility/user_data_provider.dart';

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
            home: CustomBottomAppbar(routeIndex: 0,),
            routes: {
              "/sign-in": (context) => const SignInScreen(fromWhere: 0, novel: "none", routeIndex: 99,),
              "/sign-up": (context) => const SignUpScreen(),
            }
        )
    );
  }
}