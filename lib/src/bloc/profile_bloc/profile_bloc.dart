import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_club/src/data/local/data_source/app_data_source.dart';
import 'package:blog_club/src/data/model/profile_model.dart';
import 'package:blog_club/src/view/screens/article_screen/article_view.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  late AppDatasource _appDatasource;

  ProfileBloc({required AppDatasource appDatasource})
      : super(ProfileLoading()) {
    _appDatasource = appDatasource;
    on<ProfileStarted>(_onStarted);
    on<ProfileScrolled>(_onScrolled);
    on<ProfilePostsButtonClicked>(_onPostsButtonClicked);
    on<ProfileFollowingButtonClicked>(_onFollowingButtonClicked);
    on<ProfileFollowersButtonClicked>(_onFollowersButtonClicked);
    on<ProfileNavigateTo>(_onNavigateTo);
  }

  _onStarted(ProfileStarted event, Emitter<ProfileState> emit) async {
    await Future.delayed(const Duration(seconds: 2));

    emit(ProfileSuccess(profileModel: _appDatasource.profile));
  }

  _onPostsButtonClicked(
      ProfilePostsButtonClicked event, Emitter<ProfileState> emit) {
    emit(_buttonsStateChanged(
        isPostsClicked: !(state as ProfileSuccess).isPostsClicked,
        isFollowingClicked: false,
        isFollowersClicked: false));
  }

  _onFollowingButtonClicked(
      ProfileFollowingButtonClicked event, Emitter<ProfileState> emit) {
    emit(_buttonsStateChanged(
        isPostsClicked: false,
        isFollowingClicked: !(state as ProfileSuccess).isFollowingClicked,
        isFollowersClicked: false));
  }

  _onFollowersButtonClicked(
      ProfileFollowersButtonClicked event, Emitter<ProfileState> emit) {
    emit(_buttonsStateChanged(
        isPostsClicked: false,
        isFollowingClicked: false,
        isFollowersClicked: !(state as ProfileSuccess).isFollowersClicked));
  }

  ProfileState _buttonsStateChanged(
      {required bool isPostsClicked,
      required bool isFollowingClicked,
      required bool isFollowersClicked}) {
    return (state as ProfileSuccess).copyWith(
        isFollowingClicked: isFollowingClicked,
        isFollowersClicked: isFollowersClicked,
        isPostsClicked: isPostsClicked);
  }

  _onScrolled(ProfileScrolled event, Emitter<ProfileState> emit) {
    emit((state as ProfileSuccess).copyWith(isScrolled: event.isScrolled));
  }



  _onNavigateTo(ProfileNavigateTo event, Emitter<ProfileState> emit) {
    Navigator.of(event.context).push(MaterialPageRoute(builder: (settings)=>ArticleView()));
  }
}
