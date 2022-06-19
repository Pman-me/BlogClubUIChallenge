import 'package:blog_club/gen/assets.gen.dart';
import 'package:blog_club/gen/colors.gen.dart';
import 'package:blog_club/src/configs/app_routes.dart';
import 'package:blog_club/src/configs/app_theme.dart';

import 'package:blog_club/src/core/constants/general_constants.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final int _homeScreenIndex = 0;
  final int _articleScreenIndex = 1;
  final int _searchScreenIndex = 2;
  final int _profileScreenIndex = 3;
  late int _currentScreenIndex = _homeScreenIndex;

  final GlobalKey<NavigatorState> _homeScreenNavigatorKey = GlobalKey();
  final GlobalKey<NavigatorState> _articleScreenNavigatorKey = GlobalKey();
  final GlobalKey<NavigatorState> _searchScreenNavigatorKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileScreenNavigatorKey = GlobalKey();

  late final indexToKeyMap = {
    _homeScreenIndex: _homeScreenNavigatorKey,
    _articleScreenIndex: _articleScreenNavigatorKey,
    _searchScreenIndex: _searchScreenNavigatorKey,
    _profileScreenIndex: _profileScreenNavigatorKey
  };

  final Set<int> _screensHistory = {};

  Future<bool> _onWillPop() async {
    var currentNavigatorState =
        indexToKeyMap[_currentScreenIndex]!.currentState;
    if (currentNavigatorState!.canPop()) {
      currentNavigatorState.pop();
      return false;
    }
    else if (_screensHistory.isNotEmpty) {
      setState(() {
        _currentScreenIndex = _screensHistory.last;
        _screensHistory.remove(_screensHistory.last);
      });
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              bottom: kBottomNavigationHeight,
              child: IndexedStack(
                index: _currentScreenIndex,
                children: [
                  _navigator(
                      key: _homeScreenNavigatorKey,
                      routeName: AppRoutes.kHomeScreenRoute,
                      screenIndex: _homeScreenIndex,
                      currentIndex: _currentScreenIndex),
                  _navigator(
                      key: _articleScreenNavigatorKey,
                      routeName: AppRoutes.kArticleScreenRoute,
                      screenIndex: _articleScreenIndex,
                      currentIndex: _currentScreenIndex),
                  _navigator(
                      key: _searchScreenNavigatorKey,
                      routeName: AppRoutes.kSearchScreenRoute,
                      screenIndex: _searchScreenIndex,
                      currentIndex: _currentScreenIndex),
                  _navigator(
                      key: _profileScreenNavigatorKey,
                      routeName: AppRoutes.kProfileScreenRoute,
                      screenIndex: _profileScreenIndex,
                      currentIndex: _currentScreenIndex),
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: _mainScreenBottomNavigation())
          ],
        ),
      ),
    );
  }

  Widget _navigator(
      {required GlobalKey key,
      required String routeName,
      required int screenIndex,
      required int currentIndex}) {
    return key.currentState == null && screenIndex != currentIndex
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) =>
                AppRoutes.generateRoute(settings.copyWith(
              name: routeName,
              arguments: {'offStage': screenIndex != currentIndex,'callback':_onWillPop},
            )),
          );
  }

  Widget _mainScreenBottomNavigation() {
    return Container(
      width: double.infinity,
      height: 85,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: kBottomNavigationHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: ColorName.bottomNavBoxShadowColor.withOpacity(0.3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _bottomNavigationItem(
                    iconFileName: Assets.img.icons.home.path,
                    activeIconFileName: Assets.img.icons.home.path,
                    label: 'Home',
                    isCurrentItem: _currentScreenIndex == _homeScreenIndex,
                    selectedScreenIndex: _homeScreenIndex,
                  ),
                  _bottomNavigationItem(
                    iconFileName: Assets.img.icons.articles.path,
                    activeIconFileName: Assets.img.icons.articles.path,
                    label: 'Articles',
                    isCurrentItem: _currentScreenIndex == _articleScreenIndex,
                    selectedScreenIndex: _articleScreenIndex,
                  ),
                  const Expanded(
                    child: SizedBox(
                      width: 8,
                    ),
                  ),
                  _bottomNavigationItem(
                    iconFileName: Assets.img.icons.search.path,
                    activeIconFileName: Assets.img.icons.search.path,
                    label: 'Search',
                    isCurrentItem: _currentScreenIndex == _searchScreenIndex,
                    selectedScreenIndex: _searchScreenIndex,
                  ),
                  _bottomNavigationItem(
                    iconFileName: Assets.img.icons.menu.path,
                    activeIconFileName: Assets.img.icons.menu.path,
                    label: 'Menu',
                    isCurrentItem: _currentScreenIndex == _profileScreenIndex,
                    selectedScreenIndex: _profileScreenIndex,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(4),
              child: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: ColorName.primaryColor),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _bottomNavigationItem(
      {required String iconFileName,
      required String activeIconFileName,
      required String label,
      required bool isCurrentItem,
      required int selectedScreenIndex}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _screensHistory.add(_currentScreenIndex);
            _currentScreenIndex = selectedScreenIndex;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconFileName,
              width: 24,
              height: 24,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              label,
              style: isCurrentItem
                  ? lightTheme.textTheme.caption!
                      .apply(color: lightTheme.colorScheme.primary)
                  : lightTheme.textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}
