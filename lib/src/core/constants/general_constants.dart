import 'package:flutter/material.dart';

GlobalKey<NavigatorState> kNavigatorKey = GlobalKey<NavigatorState>();
BuildContext get kAppContext => kNavigatorKey.currentContext!;
const double kBottomNavigationHeight = 65;
const double kToolbarHeight = 56;
RegExp emailRegex = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
RegExp spaceRegex =RegExp(r'\s');
