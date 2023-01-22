import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'member/screens/member_join_screen.dart';
import 'novel/api/novel_responses.dart';
import 'novel/api/spring_novel_api.dart';
import 'utility/providers/category_provider.dart';
import 'utility/providers/comment_provider.dart';
import 'utility/providers/episode_provider.dart';
import 'utility/providers/notice_provider.dart';
import 'utility/providers/novel_list_provider.dart';
import 'utility/providers/qna_provider.dart';
import 'widgets/custom_bottom_appbar.dart';
import 'member/screens/sign_in_screen.dart';
import 'member/screens/sign_up_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (BuildContext context) => CategoryProvider()),
          ChangeNotifierProvider(
              create: (BuildContext context) => QnaProvider()),
          ChangeNotifierProvider(
              create: (BuildContext context) => CommentProvider()),
          ChangeNotifierProvider(
              create: (BuildContext context) => EpisodeProvider()),
          ChangeNotifierProvider(
              create: (BuildContext context) => NoticeProvider()),
          ChangeNotifierProvider(
              create: (BuildContext context) => NovelListProvider()),
          FutureProvider<List<NovelListResponse>>(
              initialData: [],
              create: (_) => SpringNovelApi().getAllNovelList()),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              appBarTheme: const AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle.dark)),
          home: CustomBottomAppbar(
            routeIndex: 0,
          ),
          routes: {
            "/sign-in": (context) => const SignInScreen(
              fromWhere: 0,
              novel: "none",
              routeIndex: 99,
            ),
            "/sign-up": (context) => const SignUpScreen(),
            "/member-join": (context) => const MemberJoinScreen(),
          },
        ));
  }
}
