import 'package:blog_club/gen/assets.gen.dart';
import 'package:blog_club/gen/colors.gen.dart';
import 'package:blog_club/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData get lightTheme => ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorName.white,
        foregroundColor: ColorName.primaryTextColor,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark),
      ),
      colorScheme: const ColorScheme.light(
        primary: ColorName.primaryColor,
        onPrimary: ColorName.white,
        surface: ColorName.white,
        onSurface: ColorName.primaryTextColor,
        background: ColorName.background,
        onBackground: ColorName.primaryTextColor,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
            const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.avenir,
                color: ColorName.primaryColor),
          ),
        ),
      ),
      textTheme: const TextTheme(
          headline6: TextStyle(
              fontFamily: FontFamily.avenir,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: ColorName.primaryTextColor),
          headline5: TextStyle(
              fontFamily: FontFamily.avenir,
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: ColorName.primaryTextColor),
          headline4: TextStyle(
              fontFamily: FontFamily.avenir,
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: ColorName.primaryTextColor),
          caption: TextStyle(
              fontFamily: FontFamily.avenir,
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: ColorName.captionTextColor),
          subtitle1: TextStyle(
              fontFamily: FontFamily.avenir,
              fontWeight: FontWeight.w200,
              fontSize: 18,
              color: ColorName.secondaryTextColor),
          subtitle2: TextStyle(
              fontFamily: FontFamily.avenir,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: ColorName.primaryTextColor),
          bodyText2: TextStyle(
              fontFamily: FontFamily.avenir,
              fontSize: 12,
              color: ColorName.secondaryTextColor),
        bodyText1: TextStyle(
          fontFamily: FontFamily.avenir,
          fontWeight: FontWeight.w400,
          fontSize: 14,
            color: ColorName.primaryTextColor,
        )

      ),
      iconTheme: const IconThemeData(color: Colors.black),
    );
