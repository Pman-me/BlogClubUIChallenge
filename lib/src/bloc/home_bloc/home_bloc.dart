import 'dart:async';

import 'package:blog_club/src/bloc/home_bloc/home_event.dart';
import 'package:blog_club/src/bloc/home_bloc/home_state.dart';
import 'package:blog_club/src/configs/app_routes.dart';
import 'package:blog_club/src/data/local/data_source/app_data_source.dart';
import 'package:blog_club/src/data/model/category_model.dart';
import 'package:blog_club/src/data/model/post_model.dart';
import 'package:blog_club/src/data/model/story_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late final List<PostModel> _posts;

  late final List<StoryModel> _stories;

  late final List<CategoryModel> _categories;

  late AppDatasource _appDatasource;

  HomeBloc({required AppDatasource appDatasource})
      : _appDatasource = appDatasource,
        super(HomeState()) {
    on<HomeStarted>(_onStarted);
    on<HomeSliderPageChange>(_onSliderPageChanged);
    on<HomeNavigateToArticle>(_onNavigateToArticle);
    on<HomeNavigateToProfile>(_onNavigateToProfile);
  }

  _onSliderPageChanged(HomeSliderPageChange event, Emitter<HomeState> emit) {
    if (state.status == HomeStatus.success) {
      emit(state.copyWith(
          currentIndex: event.currentIndex, status: HomeStatus.success));
    }
  }

  _onStarted(HomeStarted event, Emitter<HomeState> emit) async {
    await Future.delayed(const Duration(seconds: 2)).then((value) {
      _posts = _appDatasource.posts;
      _stories = _appDatasource.stories;
      _categories = _appDatasource.categories;
    });
    emit(HomeState(
        status: HomeStatus.success,
        stories: _stories,
        posts: _posts,
        categories: _categories));
  }

  _onNavigateToArticle(HomeNavigateToArticle event, Emitter<HomeState> emit) {
    GoRouter.of(event.context).pushNamed(AppRoutes.kArticleScreenRoute);
  }

  _onNavigateToProfile(HomeNavigateToProfile event, Emitter<HomeState> emit) {
    GoRouter.of(event.context).pushNamed(AppRoutes.kProfileScreenRoute
    );
  }
}
