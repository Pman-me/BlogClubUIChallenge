import 'package:flutter/material.dart';

GlobalKey<NavigatorState> kNavigatorKey = GlobalKey<NavigatorState>();
BuildContext get kAppContext => kNavigatorKey.currentContext!;

RegExp emailRegex = RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");