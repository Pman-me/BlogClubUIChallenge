import 'package:blog_club/src/configs/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageComponent extends StatelessWidget {
  String _assetName;
  BorderRadius? _borderRadius;
  final double? width;
  final double? height;

  ImageComponent(
      {Key? key,
      required String assetName,
      BorderRadius? borderRadius,
      this.width,
      this.height})
      : _assetName = assetName,
        _borderRadius = borderRadius ?? BorderRadius.zero,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: _borderRadius,
      child: Image.asset(
        _assetName,
        fit: BoxFit.cover,
        width: width,
        height: height,

      ),
    );
  }
}
