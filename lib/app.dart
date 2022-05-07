import 'package:blog_club/src/configs/app_routes.dart';
import 'package:flutter/material.dart';

import 'src/configs/app_theme.dart';
import 'src/view/screens/home_screen/home_view.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      routerDelegate: AppRoutes.router.routerDelegate,
      routeInformationParser: AppRoutes.router.routeInformationParser,
    );
  }
}
