import 'package:blog_club/gen/assets.gen.dart';
import 'package:blog_club/gen/colors.gen.dart';
import 'package:blog_club/src/bloc/main_bloc/main_bloc.dart';
import 'package:blog_club/src/bloc/main_bloc/main_event.dart';
import 'package:blog_club/src/configs/app_theme.dart';
import 'package:blog_club/src/core/constants/general_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreenBottomNavigation extends StatelessWidget{
  MainScreenBottomNavigation({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    MainBloc mainBloc = context.read<MainBloc>();
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
                    color:
                    ColorName.bottomNavBoxShadowColor.withOpacity(0.3),
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
                    isCurrentItem: mainBloc.state.currentScreenIndex == mainBloc.state.homeScreenIndex,
                    onTap: () => mainBloc.add(
                      MainNavigateTo(
                          currentScreenIndex: mainBloc.state.homeScreenIndex),
                    ),
                  ),
                  _bottomNavigationItem(
                    iconFileName: Assets.img.icons.articles.path,
                    activeIconFileName: Assets.img.icons.articles.path,
                    label: 'Articles',
                    isCurrentItem: mainBloc.state.currentScreenIndex == mainBloc.state.articleScreenIndex,
                    onTap: () => mainBloc.add(
                      MainNavigateTo(
                          currentScreenIndex: mainBloc.state.articleScreenIndex),
                    ),
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
                    isCurrentItem: mainBloc.state.currentScreenIndex == mainBloc.state.searchScreenIndex,
                    onTap: () => mainBloc.add(
                      MainNavigateTo(
                          currentScreenIndex: mainBloc.state.searchScreenIndex),
                    ),
                  ),
                  _bottomNavigationItem(
                    iconFileName: Assets.img.icons.menu.path,
                    activeIconFileName: Assets.img.icons.menu.path,
                    label: 'Menu',
                    isCurrentItem: mainBloc.state.currentScreenIndex == mainBloc.state.profileScreenIndex,
                    onTap: () => mainBloc.add(
                      MainNavigateTo(
                          currentScreenIndex: mainBloc.state.profileScreenIndex),
                    ),
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
        VoidCallback? onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconFileName,
              width: 24,
              height: 24,
            ),
            const SizedBox(height: 4,),
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