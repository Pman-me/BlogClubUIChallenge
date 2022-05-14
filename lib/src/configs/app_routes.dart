import 'package:blog_club/src/view/screens/article_screen/article_view.dart';
import 'package:blog_club/src/view/screens/auth_screen/auth_view.dart';
import 'package:blog_club/src/view/screens/home_screen/home_view.dart';
import 'package:blog_club/src/view/screens/main_screen/main_view.dart';
import 'package:blog_club/src/view/screens/onBoarding_screen/onBoarding_view.dart';
import 'package:blog_club/src/view/screens/profile_screen/profile_view.dart';
import 'package:blog_club/src/view/screens/search_screen/search_view.dart';
import 'package:blog_club/src/view/screens/splash_screen/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String kSplashRoute = '/';
  static const String kMainScreenRoute = '/mainScreen';
  static const String kHomeScreenRoute = '/homeScreen';
  static const String kOnBoardingScreenRoute = '/onBoardingScreen';
  static const String kAuthScreenRoute = '/AuthScreen';
  static const String kArticleScreenRoute = '/ArticleScreen';
  static const String kSearchScreenRoute = '/SearchScreen';
  static const String kProfileScreenRoute = '/ProfileScreen';


  static Route<dynamic> generateRoute(RouteSettings settings) {

    var route;

    switch (settings.name) {
      case kSplashRoute:
        route = MaterialPageRoute(builder: (_) =>  SplashView());
        break;
      case kMainScreenRoute:
        route = MaterialPageRoute(builder: (_) => MainView());
        break;
      case kHomeScreenRoute:
        route = MaterialPageRoute(builder: (_) => Offstage(offstage:((settings.arguments) as Map<String,bool>)['offStage']!,child: HomeView(),));
        break;
      case kOnBoardingScreenRoute:
        route = MaterialPageRoute(builder: (_) => OnBoardingView());
      break;
      case kAuthScreenRoute:
        route = MaterialPageRoute(builder: (_) => AuthView());
        break;
      case kArticleScreenRoute:
        route = MaterialPageRoute(builder: (_) => Offstage(offstage:((settings.arguments) as Map<String,bool>)['offStage']!,child: ArticleView(),));
        break;
      case kSearchScreenRoute:
        route = MaterialPageRoute(builder: (_) => Offstage(offstage:((settings.arguments) as Map<String,bool>)['offStage']!,child: SearchView(),));
        break;
      case kProfileScreenRoute:
        route = MaterialPageRoute(builder: (_) => Offstage(offstage:((settings.arguments) as Map<String,bool>)['offStage']!,child: ProfileView(),));
        break;

    }
    return route;
  }

}
