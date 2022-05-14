import 'package:blog_club/src/configs/app_routes.dart';
import 'package:blog_club/src/data/local/data_source/app_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/configs/app_theme.dart';
import 'src/view/screens/home_screen/home_view.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context)=>AppDatasource(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        initialRoute: AppRoutes.kSplashRoute,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
