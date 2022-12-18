import 'package:flutter/material.dart';
import './colors.dart';

class AppTextThemes {
  static const double headline1Size = 48;
  static const double headline2Size = 30;
  static const double headline3Size = 28;
  static const double headline4Size = 24;
  static const double headline5Size = 22;
  static const double headline6Size = 18;
  static const double subtile1Size = 17.5;
  static const double subtile2Size = 14.5;
  static const double body1Size = 13.5;
  static const double body2Size = 12.5;
  static const double buttonSize = 14;
  static const double caption = 11;
  static const double overline = 10.5;

  static const TextTheme mobileTextThemeLight = TextTheme(
    headline1: TextStyle(
      fontFamily: "DINRoundPro",
      fontSize: headline1Size,
      color: AppColors.black,
      fontWeight: FontWeight.w400,
    ),
    headline2: TextStyle(
      fontFamily: "DINRoundPro",
      fontSize: headline2Size,
      color: AppColors.black,
      fontWeight: FontWeight.w600,
    ),
    headline3: TextStyle(
      fontFamily: "DINRoundPro",
      fontSize: headline3Size,
      color: AppColors.black,
      fontWeight: FontWeight.w500,
    ),
    headline4: TextStyle(
      fontFamily: "DINRoundPro",
      fontSize: headline4Size,
      color: AppColors.black,
      fontWeight: FontWeight.w400,
    ),
    headline5: TextStyle(
      fontFamily: "DINRoundPro",
      fontSize: headline5Size,
      color: AppColors.black,
      fontWeight: FontWeight.w500,
    ),
    headline6: TextStyle(
      fontFamily: "DINRoundPro",
      fontSize: headline6Size,
      color: AppColors.black,
      fontWeight: FontWeight.w600,
    ),
    subtitle1: TextStyle(
      fontFamily: "DINRoundPro",
      fontSize: subtile1Size,
      color: AppColors.black,
      fontWeight: FontWeight.w400,
    ),
    subtitle2: TextStyle(
      fontFamily: "DINRoundPro",
      fontSize: subtile2Size,
      color: AppColors.black,
      fontWeight: FontWeight.w700,
    ),
    bodyText1: TextStyle(
      fontFamily: "DINRoundPro",
      fontSize: body1Size,
      color: AppColors.grey,
      fontWeight: FontWeight.w400,
    ),
    bodyText2: TextStyle(
      fontFamily: "DINRoundPro",
      fontSize: body2Size,
      color: AppColors.black,
      fontWeight: FontWeight.w400,
    ),
    button: TextStyle(
      fontFamily: "DINRoundPro",
      fontSize: buttonSize,
      color: AppColors.white,
      fontWeight: FontWeight.w600,
    ),
    caption: TextStyle(
      fontFamily: "DINRoundPro",
      fontSize: caption,
      color: AppColors.black,
      fontWeight: FontWeight.w400,
    ),
    overline: TextStyle(
      fontFamily: "DINRoundPro",
      fontSize: overline,
      color: AppColors.black,
      fontWeight: FontWeight.w400,
    ),
  );

  static const TextTheme mobileTextThemeDark = TextTheme(
    headline1: TextStyle(
      fontFamily: "DINRoundPro",
      fontSize: headline1Size,
      color: AppColors.white,
      fontWeight: FontWeight.w400,
    ),
    headline2: TextStyle(
      fontFamily: "DINRoundPro",
      fontSize: headline2Size,
      color: AppColors.white,
      fontWeight: FontWeight.w600,
    ),
    headline3: TextStyle(
      fontFamily: "DINRoundPro",
      fontSize: headline3Size,
      color: AppColors.white,
      fontWeight: FontWeight.w500,
    ),
    headline4: TextStyle(
      fontFamily: "DINRoundPro",
      fontSize: headline4Size,
      color: AppColors.white,
      fontWeight: FontWeight.w400,
    ),
    headline5: TextStyle(
      fontFamily: "DINRoundPro",
      fontSize: headline5Size,
      color: AppColors.white,
      fontWeight: FontWeight.w500,
    ),
    headline6: TextStyle(
      fontFamily: "DINRoundPro",
      fontSize: headline6Size,
      color: AppColors.lightGrey,
      fontWeight: FontWeight.w600,
    ),
    subtitle1: TextStyle(
      fontFamily: "DINRoundPro",
      fontSize: subtile1Size,
      color: AppColors.white,
      fontWeight: FontWeight.w400,
    ),
    subtitle2: TextStyle(
      fontFamily: "DINRoundPro",
      fontSize: subtile2Size,
      color: AppColors.lightGrey,
      fontWeight: FontWeight.w700,
    ),
    bodyText1: TextStyle(
      fontFamily: "DINRoundPro",
      fontSize: body1Size,
      color: AppColors.lightGrey,
      height: 1.35,
      fontWeight: FontWeight.w400,
    ),
    bodyText2: TextStyle(
      fontFamily: "DINRoundPro",
      fontSize: body2Size,
      color: AppColors.white,
      fontWeight: FontWeight.w400,
    ),
    button: TextStyle(
      fontFamily: "DINRoundPro",
      fontSize: buttonSize,
      color: AppColors.white,
      fontWeight: FontWeight.w600,
    ),
    caption: TextStyle(
      fontFamily: "DINRoundPro",
      fontSize: caption,
      color: AppColors.white,
      fontWeight: FontWeight.w400,
    ),
    overline: TextStyle(
      fontFamily: "DINRoundPro",
      fontSize: overline,
      color: AppColors.white,
      fontWeight: FontWeight.w400,
    ),
  );
}
