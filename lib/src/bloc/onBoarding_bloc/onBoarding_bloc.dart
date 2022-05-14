
import 'package:blog_club/src/bloc/onBoarding_bloc/onBoarding_event.dart';
import 'package:blog_club/src/bloc/onBoarding_bloc/onBoarding_state.dart';
import 'package:blog_club/src/configs/app_routes.dart';
import 'package:blog_club/src/data/local/data_source/app_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  final _appDatasource;

  OnBoardingBloc({required AppDatasource appDatasource})
      : _appDatasource = appDatasource,
        super(OnBoardingState(onBoardingItems: [], isReachedMaxPage: false)) {
    on<OnBoardingStarted>(_onStarted);
    on<OnBoardingPageChanged>(_onPageChanged);
    on<OnBoardingNavigateTo>(_onNavigateTo);
  }

  _onStarted(OnBoardingStarted event, Emitter<OnBoardingState> emit) {
    emit(state.copyWith(onBoardingItems: _appDatasource.onBoardingItems));
  }

  _onNavigateTo(OnBoardingNavigateTo event, Emitter<OnBoardingState> emit) {
    if (_isReachedMaxPageCheck(event.pageController)) {
      Navigator.pushReplacementNamed(event.context,AppRoutes.kAuthScreenRoute);
    }
    event.pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  bool _isReachedMaxPageCheck(PageController pageController) =>
      (pageController.hasClients &&
          (pageController.page!.round() == state.onBoardingItems.length - 1));

  _onPageChanged(OnBoardingPageChanged event, Emitter<OnBoardingState> emit) {
    if (_isReachedMaxPageCheck(event.pageController)) {
      emit(state.copyWith(isReachedMaxPage: true));
    } else {
      emit(state.copyWith(isReachedMaxPage: false));
    }
  }
}
