import 'package:blog_club/src/bloc/article_bloc/article_bloc.dart';
import 'package:blog_club/src/bloc/auth_bloc/auth_bloc.dart';
import 'package:blog_club/src/bloc/home_bloc/home_bloc.dart';
import 'package:blog_club/src/bloc/onBoarding_bloc/onBoarding_bloc.dart';
import 'package:blog_club/src/bloc/profile_bloc/profile_bloc.dart';
import 'package:blog_club/src/configs/app_routes.dart';
import 'package:blog_club/src/data/local/data_source/app_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/bloc/splash_bloc/splash_bloc.dart';
import 'src/configs/app_theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AppDatasource(),
          lazy: true,
        ),
        RepositoryProvider(
          create: (context) => SplashBloc(),
          lazy: true,
        ),RepositoryProvider(
          create: (context) => OnBoardingBloc(appDatasource: RepositoryProvider.of<AppDatasource>(context)),
          lazy: true,
        ),RepositoryProvider(
          create: (context) => AuthBloc(),
          lazy: true,
        ),RepositoryProvider(
          create: (context) => HomeBloc(appDatasource: RepositoryProvider.of<AppDatasource>(context)),
          lazy: true,
        ),RepositoryProvider(
          create: (context) => ArticleBloc(appDataSource:  RepositoryProvider.of<AppDatasource>(context)),
          lazy: true,
        ),RepositoryProvider(
          create: (context) => ProfileBloc(appDatasource: RepositoryProvider.of<AppDatasource>(context)),
          lazy: true,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        initialRoute: AppRoutes.kSplashRoute,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
