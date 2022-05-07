import 'package:blog_club/gen/colors.gen.dart';
import 'package:blog_club/src/view/components/image_component.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  String _assetName;
  double _outerBoxSize;
  double _innerBoxSize;

  UserAvatar(
      {Key? key, required String assetName,
      required double outerBoxSize,
      required double innerBoxSize})
      : _assetName = assetName,
        _outerBoxSize = outerBoxSize,
        _innerBoxSize = innerBoxSize, super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _outerBoxSize,
      height: _outerBoxSize,
      child: Container(
        width: _innerBoxSize,
        height: _innerBoxSize,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              ColorName.gradiantStartColor,
              ColorName.gradiantMiddleColor,
              ColorName.gradiantEndColor
            ],
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: Colors.white,
          ),
          child: ImageComponent(
            assetName: _assetName,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
