import 'dart:async';

import 'package:blog_club/src/bloc/splash_bloc/splash_event.dart';
import 'package:blog_club/src/bloc/splash_bloc/splash_state.dart';
import 'package:blog_club/src/configs/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState()) {
    on<NavigateToEvent>(_onNavigateTo);
  }

  _onNavigateTo(NavigateToEvent event, Emitter<SplashState> emit) {
    Future.delayed(const Duration(seconds: 2))
        .then((value) => Navigator.pushReplacementNamed(event.context,AppRoutes.kOnBoardingScreenRoute));
  }
}
