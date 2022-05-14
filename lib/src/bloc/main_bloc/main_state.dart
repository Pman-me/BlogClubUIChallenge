import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class MainState extends Equatable {
  int currentScreenIndex;
  final int homeScreenIndex = 0;
  final int articleScreenIndex = 1;
  final int searchScreenIndex = 2;
  final int profileScreenIndex = 3;

  GlobalKey<NavigatorState> homeScreenNavigatorKey = GlobalKey();
  GlobalKey<NavigatorState> articleScreenNavigatorKey = GlobalKey();
  GlobalKey<NavigatorState> searchScreenNavigatorKey = GlobalKey();
  GlobalKey<NavigatorState> profileScreenNavigatorKey = GlobalKey();

  late final indexToKeyMap = {
    homeScreenIndex:homeScreenNavigatorKey,
    articleScreenIndex:articleScreenNavigatorKey,
    searchScreenIndex:searchScreenNavigatorKey,
    profileScreenIndex:profileScreenNavigatorKey
  };

   Set<int> screensHistory = {};

  @override
  List<Object?> get props => [currentScreenIndex,screensHistory];

  MainState({required this.currentScreenIndex});

  MainState copyWith({required int? currentScreenIndex}){
    return MainState(currentScreenIndex: currentScreenIndex ?? this.currentScreenIndex,)..screensHistory= screensHistory;
  }
}
