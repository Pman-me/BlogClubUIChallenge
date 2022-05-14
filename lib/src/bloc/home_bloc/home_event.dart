import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeStarted extends HomeEvent {}

class HomeSliderPageChange extends HomeEvent {
  int _currentIndex;

  int get currentIndex => _currentIndex;

  HomeSliderPageChange({required int index}) : _currentIndex = index;

  @override
  List<Object> get props => [_currentIndex];
}

class HomeNavigateTo extends HomeEvent{
  var context;
  HomeNavigateTo({required this.context});
}

