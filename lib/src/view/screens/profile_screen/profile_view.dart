import 'package:blog_club/gen/assets.gen.dart';
import 'package:blog_club/gen/colors.gen.dart';
import 'package:blog_club/src/bloc/profile_bloc/profile_bloc.dart';
import 'package:blog_club/src/configs/app_theme.dart';
import 'package:blog_club/src/data/local/data_source/app_data_source.dart';
import 'package:blog_club/src/view/components/post_list_shimmer_component.dart';
import 'package:blog_club/src/view/components/post_list_component.dart';
import 'package:blog_club/src/view/components/shimmer_component.dart';
import 'package:blog_club/src/view/components/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  late ScrollController _scrollController;
  final double _kToolbarHeight = 56;

  @override
  Widget build(BuildContext context) {
    var _outerContainerHeight = MediaQuery.of(context).size.height * 0.45;
    var _innerContainerHeight = MediaQuery.of(context).size.height * 0.35;

    return BlocProvider(
      create: (context) => ProfileBloc(AppDatasource())..add(ProfileStarted()),
      child: Scaffold(
        backgroundColor: lightTheme.colorScheme.background,
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            var result;
            if (state is ProfileLoading) {
              result = _loadingStateView(context, _innerContainerHeight);
            }
            if (state is ProfileSuccess) {
              _scrollController = ScrollController();
              _scrollController.addListener(() {
                var _isScrolled = _scrollController.hasClients &&
                    _scrollController.offset > 56;
                context
                    .read<ProfileBloc>()
                    .add(ProfileScrolled(isScrolled: _isScrolled));
              });

              result = _successStateView(
                  _outerContainerHeight, _innerContainerHeight, state, context);
            }
            return result;
          },
        ),
      ),
    );
  }

  Widget _loadingStateView(BuildContext context, double _innerContainerHeight) {
    return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  toolbarHeight: _kToolbarHeight,
                  elevation: 0,
                  backgroundColor: lightTheme.colorScheme.background,
                  automaticallyImplyLeading: false,
                  title: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 16),
                    child: Text(
                      'Profile',
                      style: lightTheme.textTheme.headline4,
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 16),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_horiz_outlined),
                      ),
                    ),
                  ],
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        padding: const EdgeInsets.all(32),
                        margin: const EdgeInsets.fromLTRB(32, 16, 32, 0),
                        height: _innerContainerHeight,
                        decoration: BoxDecoration(
                          color: lightTheme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 20,
                              color: lightTheme.colorScheme.onBackground
                                  .withOpacity(0.1),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ShimmerComponent.rectangular(
                                  height: 84,
                                  width: 84,
                                  shapeBorder: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(16)),
                                ),
                                const SizedBox(
                                  width: 32,
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: const [
                                    ShimmerComponent.rectangular(
                                      height: 15,
                                      width: 100,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    ShimmerComponent.rectangular(
                                      height: 15,
                                      width: 100,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    ShimmerComponent.rectangular(
                                      height: 15,
                                      width: 100,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            const ShimmerComponent.rectangular(
                              height: 20,
                              width: 100,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const ShimmerComponent.rectangular(
                              height: 15,
                              width: 400,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const ShimmerComponent.rectangular(
                              height: 15,
                              width: 100,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 72,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: lightTheme.colorScheme.surface,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 20,
                                  color: lightTheme.colorScheme.onBackground
                                      .withOpacity(0.01))
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 64,
                            ),
                            PostListLoadingStateView(),
                            const SizedBox(
                              height: 16,
                            ),
                            PostListLoadingStateView(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
  }

  Widget _successStateView(
      double _outerContainerHeight,
      double _innerContainerHeight,
      ProfileSuccess state,
      BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          pinned: true,
          floating: true,
          toolbarHeight: _kToolbarHeight,
          elevation: state.isScrolled ? 4 : 0,
          backgroundColor: state.isScrolled
              ? lightTheme.colorScheme.background
              : lightTheme.colorScheme.background,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsetsDirectional.only(start: 16),
            child: Text(
              'Profile',
              style: lightTheme.textTheme.headline4,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 20),
              child: IconButton(
                onPressed: () {
                },
                icon: const Icon(Icons.more_horiz_outlined),
              ),
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: _outerContainerHeight,
                width: double.maxFinite,
                child: Stack(
                  children: [
                    Positioned.fill(
                        bottom: 18,
                        top: 32,
                        left: 96,
                        right: 96,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 20,
                                  color: lightTheme.colorScheme.onBackground
                                      .withOpacity(0.3))
                            ],
                          ),
                        )),
                    Positioned(
                      child: Container(
                        padding: const EdgeInsets.all(32),
                        margin: const EdgeInsets.fromLTRB(32, 16, 32, 0),
                        height: _innerContainerHeight,
                        decoration: BoxDecoration(
                          color: lightTheme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 20,
                              color: lightTheme.colorScheme.onBackground
                                  .withOpacity(0.1),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                UserAvatar(
                                    assetName:
                                        state.profileModel.profileImageFileName,
                                    outerBoxSize: 84,
                                    innerBoxSize: 82),
                                const SizedBox(
                                  width: 32,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(state.profileModel.id,
                                          style:
                                              lightTheme.textTheme.bodyText1),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        state.profileModel.fullname,
                                        style: lightTheme.textTheme.bodyText1!
                                            .copyWith(
                                                fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        state.profileModel.field,
                                        style: lightTheme.textTheme.bodyText1!
                                            .apply(
                                                color: lightTheme
                                                    .colorScheme.primary),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            Text(
                              'About me',
                              style: lightTheme.textTheme.headline6,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              state.profileModel.aboutMe,
                              style: lightTheme.textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom:
                          (_outerContainerHeight - _innerContainerHeight) / 2,
                      right: 64,
                      left: 64,
                      child: Container(
                        height: 68,
                        decoration: BoxDecoration(
                          color: lightTheme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            _userInfoItem(
                              title: 'Posts',
                              count: state.profileModel.posts.length.toString(),
                              isClicked: state.isPostsClicked,
                              onTap: () => context
                                  .read<ProfileBloc>()
                                  .add(ProfilePostsButtonClicked()),
                            ),
                            _userInfoItem(
                              title: 'Following',
                              count: state.profileModel.following,
                              isClicked: state.isFollowingClicked,
                              onTap: () => context
                                  .read<ProfileBloc>()
                                  .add(ProfileFollowingButtonClicked()),
                            ),
                            _userInfoItem(
                              title: 'Followers',
                              count: state.profileModel.followers,
                              isClicked: state.isFollowersClicked,
                              onTap: () => context
                                  .read<ProfileBloc>()
                                  .add(ProfileFollowersButtonClicked()),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: lightTheme.colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 20,
                        color: lightTheme.colorScheme.onBackground
                            .withOpacity(0.01))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'My Posts',
                            style: lightTheme.textTheme.headline6,
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Assets.img.icons.grid.svg(
                                  color: lightTheme.colorScheme.onBackground
                                      .withOpacity(0.4),
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Assets.img.icons.table
                                    .svg(color: lightTheme.colorScheme.primary),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    PostListComponent(
                      posts: state.profileModel.posts,
                      itemExtent: 150,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _userInfoItem(
      {required String title,
      required String count,
      required bool isClicked,
      required VoidCallback onTap}) {
    return Expanded(
        flex: 1,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: isClicked
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ColorName.darkPrimaryColor)
                : null,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  count,
                  style: lightTheme.textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: lightTheme.colorScheme.onPrimary),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  title,
                  style: lightTheme.textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w200,
                      color: lightTheme.colorScheme.onPrimary),
                )
              ],
            ),
          ),
        ));
  }
}
