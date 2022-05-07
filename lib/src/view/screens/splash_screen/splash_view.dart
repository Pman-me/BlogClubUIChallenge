import 'package:blog_club/gen/assets.gen.dart';
import 'package:blog_club/src/bloc/splash_bloc/splash_bloc.dart';
import 'package:blog_club/src/bloc/splash_bloc/splash_event.dart';
import 'package:blog_club/src/bloc/splash_bloc/splash_state.dart';
import 'package:blog_club/src/view/components/image_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            SplashBloc()..add(NavigateToEvent(context: context)),
        child: Scaffold(
          body: _splashBody(),
        ));
  }

  Widget _splashBody() {
    return BlocBuilder<SplashBloc, SplashState>(builder: (context, state) {
          return Stack(
            children: [Positioned.fill(child: ImageComponent(assetName: Assets.img.background.splashBackground.path)),Center(child: Assets.img.icons.logo.svg(),)],
          );
        });
  }
}
