import 'package:blog_club/gen/colors.gen.dart';
import 'package:blog_club/src/bloc/home_bloc/home_bloc.dart';
import 'package:blog_club/src/bloc/home_bloc/home_event.dart';
import 'package:blog_club/src/bloc/home_bloc/home_state.dart';
import 'package:blog_club/src/carousel_slider/carousel_slider.dart';
import 'package:blog_club/src/core/constants/asset_constants.dart';
import 'package:blog_club/src/configs/app_theme.dart';
import 'package:blog_club/src/data/model/story_model.dart';
import 'package:blog_club/src/view/components/image_component.dart';
import 'package:blog_club/src/view/components/post_list_shimmer_component.dart';
import 'package:blog_club/src/view/components/post_list_component.dart';
import 'package:blog_club/src/view/components/shimmer_component.dart';
import 'package:blog_club/src/view/components/user_avatar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
        RepositoryProvider.of<HomeBloc>(context)..add(HomeStarted()),
        child: _homeBody(),
      ),
    );
  }
  Widget _appbar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Hi, jonathan!',
            style: lightTheme.textTheme.subtitle1,
          ),
          Image.asset(
            kHomeAppbarIconAsset,
            width: 32,
            height: 32,
          ),
        ],
      ),
    );
  }

  Widget _homeBody() {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _appbar(),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      'Explore today\'s',
                      style: lightTheme.textTheme.headline4,
                    )),
                const SizedBox(
                  height: 16,
                ),
                _StoryList(),
                _CategoryList(),
                Padding(
                  padding: const EdgeInsets.only(left: 32, right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Latest News',
                        style: lightTheme.textTheme.headline5,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'More',
                          style: TextStyle(color: ColorName.primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                _PostList(),
                const SizedBox(
                  height: 16,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}

class _StoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      late Widget result;
      if (state.status == HomeStatus.loading) {
        result = _storyListLoadingStateView();
      }
      if (state.status == HomeStatus.success) {
        result = _storyListSuccessStateView(state);
      }
      return result;
    });
  }

  Widget _storyListLoadingStateView() {
    return SizedBox(
      width: double.maxFinite,
      height: 100,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: const ShimmerComponent.rectangular(
                    width: 68,
                    height: 68,
                    shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(24),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const ShimmerComponent.rectangular(
                  width: 40,
                  height: 10,
                )
              ],
            );
          }),
    );
  }

  Widget _storyListSuccessStateView(HomeState state) {
    return SizedBox(
      width: double.maxFinite,
      height: 100,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 32),
          scrollDirection: Axis.horizontal,
          itemCount: state.stories.length,
          itemBuilder: (context, index) {
            var story = state.stories[index];

            return _storyItem(story);
          }),
    );
  }

  Widget _storyItem(StoryModel story) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 2, 8, 0),
      child: Column(
        children: [
          Stack(
            children: [
              story.isViewed ? _seenStoryView(story) : _storyView(story),
              _storyBadge(story)
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(story.name),
        ],
      ),
    );
  }

  Widget _storyBadge(StoryModel story) {
    return Positioned(
        bottom: -2,
        right: -2,
        child: Image.asset(
          story.iconFileName,
          width: 24,
          height: 24,
        ));
  }

  Widget _storyView(StoryModel story) {
    return UserAvatar(
        assetName: story.imageFileName, outerBoxSize: 70, innerBoxSize: 68);
  }

  Widget _seenStoryView(StoryModel story) {
    return SizedBox(
      width: 70,
      height: 70,
      child: Container(
        width: 68,
        height: 68,
        padding: const EdgeInsets.all(1),
        child: DottedBorder(
          strokeWidth: 2,
          color: ColorName.dotColor,
          borderType: BorderType.RRect,
          radius: const Radius.circular(24),
          dashPattern: [10, 3],
          padding: const EdgeInsets.all(7),
          child: ImageComponent(
            assetName: story.imageFileName,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;

    return BlocConsumer<HomeBloc, HomeState>(
        listenWhen: (previous, current) {
          if (previous.currentIndex != current.currentIndex) {
            _currentIndex = current.currentIndex;
            return true;
          } else {
            return false;
          }
        },
        listener: (_, __) {},
        builder: (context, state) {
          late Widget result;
          if (state.status == HomeStatus.loading) {
            result = _categoryListLoadingState();
          }
          if (state.status == HomeStatus.success) {
            result = _categoryListSuccessState(context, state, _currentIndex);
          }
          return result;
        });
  }

  Widget _categoryListSuccessState(
      BuildContext context, HomeState state, int _currentIndex) {
    final CarouselController _carouselController = CarouselController();

    return CarouselSlider.builder(
      options: CarouselOptions(
        scrollDirection: Axis.horizontal,
        scrollPhysics: const BouncingScrollPhysics(),
        viewportFraction: 0.7,
        aspectRatio: 1.3,
        disableCenter: true,
        initialPage: 0,
        enableInfiniteScroll: true,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        padEnds: false,
        onPageChanged: (index, _) {
          context.read<HomeBloc>().add(HomeSliderPageChange(index: index));
        },
      ),
      carouselController: _carouselController,
      itemCount: state.categories.length,
      itemBuilder: (context, index, realIndex) {
        double startMargin = (index == 0 || index == _currentIndex) ? 32 : 8;

        double endMargin = 8;

        var category = state.categories[index];

        return Container(
          margin: EdgeInsetsDirectional.fromSTEB(startMargin, 0, endMargin, 8),
          child: Stack(
            children: [
              Positioned.fill(
                top: 100,
                right: 56,
                left: 56,
                bottom: 24,
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 22,
                          color: ColorName.categoryItemBoxShadowColor)
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  image: DecorationImage(
                      image: AssetImage(
                        category.imageFileName,
                      ),
                      fit: BoxFit.cover),
                ),
                foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [
                      ColorName.largePostGradiantStartColor,
                      Colors.transparent
                    ],
                  ),
                ),
              ),
              Positioned.directional(
                textDirection: TextDirection.ltr,
                start: 32,
                bottom: 48,
                child: Text(
                  category.title,
                  style: lightTheme.textTheme.headline6!
                      .apply(color: Colors.white),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _categoryListLoadingState() {
    return Container(
      margin: const EdgeInsets.fromLTRB(32, 32, 32, 16),
      child: const ShimmerComponent.rectangular(
        width: double.maxFinite,
        height: 300,
      ),
    );
  }
}

class _PostList extends StatelessWidget {
  _PostList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      late Widget result;
      if (state.status == HomeStatus.loading) {
        result = PostListLoadingStateView();
      }
      if (state.status == HomeStatus.success) {
        result = PostListComponent(
          posts: state.posts,
          itemExtent: 150,
          voidCallback: () =>
              context.read<HomeBloc>().add(HomeNavigateTo(context: context)),
        );
      }
      return result;
    });
  }
}
