import 'package:blog_club/gen/colors.gen.dart';
import 'package:blog_club/src/view/components/shimmer_component.dart';
import 'package:flutter/material.dart';

class PostListLoadingStateView extends StatelessWidget {
   PostListLoadingStateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(blurRadius: 8, color: ColorName.postItemBoxShadowColor)
        ],
      ),
      child: Row(
        children: [
           ShimmerComponent.rectangular(
            width: 150,
            height: 150,
            shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  ShimmerComponent.rectangular(
                    width: 60,
                    height: 20,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ShimmerComponent.rectangular(
                    width: 200,
                    height: 20,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ShimmerComponent.rectangular(
                    width: 100,
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
