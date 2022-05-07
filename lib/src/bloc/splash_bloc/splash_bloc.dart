import 'dart:async';

import 'package:blog_club/src/bloc/splash_bloc/splash_event.dart';
import 'package:blog_club/src/bloc/splash_bloc/splash_state.dart';
import 'package:blog_club/src/configs/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState()) {
    on<NavigateToEvent>(_onNavigateTo);
  }

  _onNavigateTo(NavigateToEvent event, Emitter<SplashState> emit) {
    Future.delayed(const Duration(seconds: 2))
        .then((value) => GoRouter.of(event.context).goNamed(AppRoutes.kOnBoardingScreenRoute));
  }
}
