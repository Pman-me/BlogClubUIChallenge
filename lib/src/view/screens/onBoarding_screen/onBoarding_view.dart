import 'package:blog_club/gen/assets.gen.dart';
import 'package:blog_club/src/bloc/onBoarding_bloc/onBoarding_bloc.dart';
import 'package:blog_club/src/bloc/onBoarding_bloc/onBoarding_event.dart';
import 'package:blog_club/src/bloc/onBoarding_bloc/onBoarding_state.dart';
import 'package:blog_club/src/configs/app_theme.dart';
import 'package:blog_club/src/data/local/data_source/app_data_source.dart';
import 'package:blog_club/src/view/components/button_component.dart';
import 'package:blog_club/src/view/components/image_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingView extends StatelessWidget {
  final PageController _pageController = PageController();

  OnBoardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OnBoardingBloc(appDatasource: AppDatasource())..add(OnBoardingStarted()),
      child: Scaffold(
        backgroundColor: lightTheme.colorScheme.background,
        body: _onBoardingBody(context),
      ),
    );
  }

  Widget _onBoardingBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _backgroundImage(),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
                color: lightTheme.colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ]),
            child: BlocBuilder<OnBoardingBloc, OnBoardingState>(
                builder: (context, state) {
              _pageController.addListener(() {
                context.read<OnBoardingBloc>().add(
                    OnBoardingPageChanged(pageController: _pageController));
              });

              return Column(
                children: [
                  _descriptionSlider(state),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmoothPageIndicator(
                          controller: _pageController,
                          count: 4,
                          effect: ExpandingDotsEffect(
                              dotWidth: 8,
                              dotHeight: 8,
                              activeDotColor: lightTheme.colorScheme.primary,
                              dotColor: lightTheme.colorScheme.primary
                                  .withOpacity(0.1)),
                        ),
                        ButtonComponent(
                          width: 80,
                          height: 60,
                          child: Icon(
                            state.isReachedMaxPage
                                ? Icons.check
                                : Icons.arrow_forward_outlined,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          voidCallback: () {
                            context.read<OnBoardingBloc>().add(
                                  OnBoardingNavigateTo(
                                      context: context,
                                      pageController: _pageController),
                                );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _descriptionSlider(OnBoardingState state) {
    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        itemCount: state.onBoardingItems.length,
        itemBuilder: (context, index) {
          var onBoardingItem = state.onBoardingItems[index];
          return Padding(
            padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  onBoardingItem.title,
                  style: lightTheme.textTheme.headline4,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  onBoardingItem.description,
                  style: lightTheme.textTheme.subtitle1!
                      .apply(fontSizeFactor: 0.9),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _backgroundImage() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 32, bottom: 8),
        child: ImageComponent(
          assetName: Assets.img.background.onboardingBackground.path,
        ),
      ),
    );
  }
}
