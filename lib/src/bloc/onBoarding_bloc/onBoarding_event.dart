import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class OnBoardingEvent extends Equatable{

  @override
  List<Object?> get props => [];
}

class OnBoardingStarted extends OnBoardingEvent{}

class OnBoardingPageChanged extends OnBoardingEvent{
  PageController pageController;

  OnBoardingPageChanged({required this.pageController});
}

class OnBoardingNavigateTo extends OnBoardingEvent{
  final context;
  PageController pageController;

  OnBoardingNavigateTo({required this.context,required this.pageController});
}