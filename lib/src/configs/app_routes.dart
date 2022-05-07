import 'package:blog_club/src/view/screens/article_screen/article_view.dart';
import 'package:blog_club/src/view/screens/auth_screen/auth_view.dart';
import 'package:blog_club/src/view/screens/home_screen/home_view.dart';
import 'package:blog_club/src/view/screens/onboarding_screen/onBoarding_view.dart';
import 'package:blog_club/src/view/screens/profile_screen/profile_view.dart';
import 'package:blog_club/src/view/screens/splash_screen/splash_view.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String kSplashRoute = 'splashScreen';
  static const String kHomeScreenRoute = 'homeScreen';
  static const String kOnBoardingScreenRoute = 'onBoardingScreen';
  static const String kAuthScreenRoute = 'AuthScreen';
  static const String kArticleScreenRoute = 'ArticleScreen';
  static const String kProfileScreenRoute = 'ProfileScreen';

  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
          path: '/',
          name: kSplashRoute,
          builder: (context, state) => SplashView()),
      GoRoute(
        path: '/home',
        name: kHomeScreenRoute,
        builder: (context, state) => HomeView(),
      ),
      GoRoute(
        path: '/onBoarding',
        name: kOnBoardingScreenRoute,
        builder: (context, state) => OnBoardingView(),
      ),
      GoRoute(
        path: '/auth',
        name: kAuthScreenRoute,
        builder: (context, state) => AuthView(),
      ),
      GoRoute(
        path: '/article',
        name: kArticleScreenRoute,
        builder: (context, state) => ArticleView(),
      ),
      GoRoute(
        path: '/profileScreen',
        name: kProfileScreenRoute,
        builder: (context, state) => ProfileView(),
      ),
    ],
  );
}
