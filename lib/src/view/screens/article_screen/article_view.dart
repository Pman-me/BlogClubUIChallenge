import 'package:blog_club/gen/assets.gen.dart';
import 'package:blog_club/src/bloc/article_bloc/article_bloc.dart';
import 'package:blog_club/src/configs/app_theme.dart';
import 'package:blog_club/src/data/local/data_source/app_data_source.dart';
import 'package:blog_club/src/view/components/button_component.dart';
import 'package:blog_club/src/view/components/image_component.dart';
import 'package:blog_club/src/view/components/shimmer_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArticleView extends StatelessWidget {
  late Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) =>
          ArticleBloc(appDataSource: RepositoryProvider.of<AppDatasource>(context))..add(ArticleStarted()),
      child: Scaffold(
        backgroundColor: lightTheme.colorScheme.surface,
        body: BlocBuilder<ArticleBloc, ArticleState>(builder: (context, state) {
          var result;

          if (state is ArticleLoading) {
            result = _loadingStateView(context);
          }
          if (state is ArticleSuccess) {
            result = _successStateView(state,context);
          }

          return result;
        }),
      ),
    );
  }

  Widget _successStateView(ArticleSuccess state,BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                leading: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 16),
                  child: IconButton(
                    onPressed: () {
                      context
                          .read<ArticleBloc>()
                          .add(ArticleNavigateToBack(context: context));
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_outlined,
                    ),
                  ),
                ),
                actions: [
                  Padding(
                      padding: const EdgeInsetsDirectional.only(end: 16),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_horiz_outlined),
                      ))
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.all(32),
                      child: Text(
                        state.article.title,
                        style: lightTheme.textTheme.headline4,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 0, 16, 32),
                      child: Row(
                        children: [
                          ImageComponent(
                            width: 56,
                            height: 56,
                            assetName: state.article.authorImageFileName,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.article.author,
                                  style: lightTheme.textTheme.bodyText1!
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(state.article.time),
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                CupertinoIcons.share,
                                color: lightTheme.colorScheme.primary,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                state.article.isBookmarked
                                    ? CupertinoIcons.bookmark_fill
                                    : CupertinoIcons.bookmark,
                                color: lightTheme.colorScheme.primary,
                              )),
                        ],
                      ),
                    ),
                    ImageComponent(
                      assetName: state.article.postImageFileName,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 32, 32, 16),
                      child: Text(
                        state.article.caption,
                        style: lightTheme.textTheme.headline5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
                      child: Text(
                        state.article.description,
                        style: lightTheme.textTheme.bodyText2!
                            .copyWith(wordSpacing: 3),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: _size.width,
            height: _size.height * 0.25,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [
                  lightTheme.colorScheme.surface,
                  lightTheme.colorScheme.surface.withOpacity(0),
                ],
              ),
            ),
          ),
        ),
        Positioned.directional(
          bottom: 16,
          end: 16,
          textDirection: TextDirection.ltr,
          child: ButtonComponent(
              width: 120,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.img.icons.thumbs.svg(
                      width: 24,
                      height: 24,
                      color: lightTheme.colorScheme.onPrimary),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    state.article.likes,
                    style: lightTheme.textTheme.bodyText1!
                        .apply(color: lightTheme.colorScheme.onPrimary),
                  )
                ],
              ),
              elevation: 10,
              shadowColor: lightTheme.colorScheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              voidCallback: () {}),
        ),
      ],
    );
  }

  Widget _loadingStateView(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 16),
                child: IconButton(
                  onPressed: () {
                    context
                        .read<ArticleBloc>()
                        .add(ArticleNavigateToBack(context: context));
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_outlined,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 16),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz_outlined),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(32),
            child: ShimmerComponent.rectangular(
              height: 40,
              width: double.maxFinite,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(32),
            child: Row(
              children: [
                ShimmerComponent.rectangular(
                  height: 56,
                  width: 56,
                  shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    ShimmerComponent.rectangular(
                      height: 20,
                      width: 200,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ShimmerComponent.rectangular(
                      height: 20,
                      width: 80,
                    ),
                  ],
                )
              ],
            ),
          ),
          ShimmerComponent.rectangular(
            height: _size.height * 0.3,
            width: double.maxFinite,
            shapeBorder: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(32),
                topLeft: Radius.circular(32),
              ),
            ),
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(32, 32, 32, 16),
              child: ShimmerComponent.rectangular(
                height: 40,
                width: double.maxFinite,
              )),
          const Padding(
              padding: EdgeInsets.fromLTRB(32, 0, 32, 8),
              child: ShimmerComponent.rectangular(
                height: 20,
                width: double.maxFinite,
              )),
          const Padding(
              padding: EdgeInsets.fromLTRB(32, 0, 32, 8),
              child: ShimmerComponent.rectangular(
                height: 20,
                width: double.maxFinite,
              )),
          const Padding(
              padding: EdgeInsets.fromLTRB(32, 0, 32, 8),
              child: ShimmerComponent.rectangular(
                height: 20,
                width: double.maxFinite,
              )),
          const Padding(
              padding: EdgeInsets.fromLTRB(32, 0, 32, 8),
              child: ShimmerComponent.rectangular(
                height: 20,
                width: 200,
              )),
        ],
      ),
    );
  }
}
