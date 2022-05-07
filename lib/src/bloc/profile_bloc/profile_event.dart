part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable{}

class ProfileStarted extends ProfileEvent {
  @override
  List<Object> get props=> [];
}

class ProfileScrolled extends ProfileEvent {

  bool _isScrolled;
  bool get isScrolled => _isScrolled;

  ProfileScrolled({required bool isScrolled}):_isScrolled = isScrolled;

  @override
  List<Object> get props=> [_isScrolled];

}

class ProfilePostsButtonClicked extends ProfileEvent {
  @override
  List<Object> get props=> [];
}

class ProfileFollowingButtonClicked extends ProfileEvent {
  @override
  List<Object> get props=> [];
}

class ProfileFollowersButtonClicked extends ProfileEvent {
  @override
  List<Object> get props=> [];
}


