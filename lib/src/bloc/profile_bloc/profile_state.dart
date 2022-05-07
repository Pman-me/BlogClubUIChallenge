part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {}

class ProfileLoading extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileSuccess extends ProfileState {
  late ProfileModel _profileModel;

  ProfileModel get profileModel => _profileModel;

  late bool isPostsClicked;
  late bool isFollowingClicked;
  late bool isFollowersClicked;
  late bool isScrolled;

  ProfileSuccess(
      {required ProfileModel profileModel,
      bool? isPostsClicked,
      bool? isFollowingClicked,
      bool? isFollowersClicked,bool? isScrolled}) {
    _profileModel = profileModel;
    this.isPostsClicked = isPostsClicked??true;
    this.isFollowingClicked = isFollowingClicked??false;
    this.isFollowersClicked = isFollowersClicked??false;
    this.isScrolled = isScrolled ??false;
  }

  ProfileState copyWith({
    ProfileModel? profileModel,
    bool? isPostsClicked,
    bool? isFollowingClicked,
    bool? isFollowersClicked,
    bool? isScrolled,
  }) {
    return ProfileSuccess(
        profileModel: profileModel ?? _profileModel,
        isPostsClicked: isPostsClicked ?? this.isPostsClicked,
        isFollowingClicked: isFollowingClicked ?? this.isFollowingClicked,
        isFollowersClicked: isFollowersClicked ?? this.isFollowersClicked,
      isScrolled: isScrolled ?? this.isScrolled,
    );
  }

  @override
  List<Object?> get props =>
      [_profileModel, isPostsClicked, isFollowingClicked, isFollowersClicked,isScrolled];
}
