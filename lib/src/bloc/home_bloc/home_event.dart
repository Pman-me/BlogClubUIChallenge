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

class HomeNavigateToArticle extends HomeEvent {
  BuildContext _context;

  BuildContext get context => _context;

  HomeNavigateToArticle({required BuildContext context}) : _context = context;
}

class HomeNavigateToProfile extends HomeEvent {
  BuildContext _context;

  BuildContext get context => _context;

  HomeNavigateToProfile({required BuildContext context}) : _context = context;
}
