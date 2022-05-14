import 'package:blog_club/src/bloc/main_bloc/main_bloc.dart';
import 'package:blog_club/src/bloc/main_bloc/main_event.dart';
import 'package:blog_club/src/bloc/main_bloc/main_state.dart';
import 'package:blog_club/src/configs/app_routes.dart';

import 'package:blog_club/src/core/constants/general_constants.dart';
import 'package:blog_club/src/view/screens/main_screen/widgets/main_screen_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainView extends StatelessWidget {
  late MainBloc _mainBloc;

  Future<bool> _onWillPop() async {
    var currentNavigatorState = _mainBloc
        .state.indexToKeyMap[_mainBloc.state.currentScreenIndex]!.currentState;
    if (currentNavigatorState!.canPop()) {
      currentNavigatorState.pop();
      return false;
    }
    if (_mainBloc.state.screensHistory.isNotEmpty) {
      _mainBloc.add(
          MainBackTo(currentScreenIndex: _mainBloc.state.screensHistory.last));
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainBloc(),
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          _mainBloc = context.read<MainBloc>();
          return WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
              body: Stack(
                children: [
                  Positioned.fill(
                    bottom: kBottomNavigationHeight,
                    child: IndexedStack(
                      index: state.currentScreenIndex,
                      children: [
                        _navigator(
                            key: state.homeScreenNavigatorKey,
                            routeName: AppRoutes.kHomeScreenRoute,
                            screenIndex: state.homeScreenIndex,
                            currentIndex: state.currentScreenIndex),
                        _navigator(
                            key: state.articleScreenNavigatorKey,
                            routeName: AppRoutes.kArticleScreenRoute,
                            screenIndex: state.articleScreenIndex,
                            currentIndex: state.currentScreenIndex),
                        _navigator(
                            key: state.searchScreenNavigatorKey,
                            routeName: AppRoutes.kSearchScreenRoute,
                            screenIndex: state.searchScreenIndex,
                            currentIndex: state.currentScreenIndex),
                        _navigator(
                            key: state.profileScreenNavigatorKey,
                            routeName: AppRoutes.kProfileScreenRoute,
                            screenIndex: state.profileScreenIndex,
                            currentIndex: state.currentScreenIndex),
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: MainScreenBottomNavigation())
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _navigator(
      {required GlobalKey key,
      required String routeName,
      required int screenIndex,
      required int currentIndex}) {
    return key.currentState ==null && screenIndex != currentIndex ? Container() :Navigator(
      key: key,
      onGenerateRoute: (settings) => AppRoutes.generateRoute(settings.copyWith(
        name: routeName,
        arguments: {'offStage': screenIndex != currentIndex},
      )),
    );
  }
}
