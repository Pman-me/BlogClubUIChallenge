import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerComponent extends StatelessWidget {
  final double height;
  final double width;
  final ShapeBorder shapeBorder;

   const ShimmerComponent.rectangular({
    this.width = double.infinity,
    required this.height,
  ShapeBorder? shapeBorder
  }):shapeBorder=shapeBorder??const RoundedRectangleBorder();

   ShimmerComponent.circular(
      {this.width = double.infinity,
      required this.height,
      this.shapeBorder = const CircleBorder()});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[200]!,
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: Colors.grey[400],
          shape: shapeBorder,
        ),
      ),
    );
  }
}
