import 'package:flutter/material.dart';
import '../../constants/font_family.dart';
import './colors.dart';

class AppTextThemes {
  static const double headline1Size = 48;
  static const double headline2Size = 30;
  static const double headline3Size = 28;
  static const double headline4Size = 26;
  static const double headline5Size = 24;
  static const double headline6Size = 22;
  static const double subtile1Size = 20;
  static const double subtile2Size = 18;
  static const double body1Size = 17;
  static const double body2Size = 15.5;
  static const double buttonSize = 15;
  static const double caption = 14;
  static const double overline = 12.5;

  static const TextTheme mobileTextThemeLight = TextTheme(
    displayLarge: TextStyle(
      fontFamily: AppFonts.DINRoundPro,
      fontSize: headline1Size,
      color: AppColors.black,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontFamily: AppFonts.DINRoundPro,
      fontSize: headline2Size,
      color: AppColors.black,
      fontWeight: FontWeight.w600,
    ),
    displaySmall: TextStyle(
      fontFamily: AppFonts.DINRoundPro,
      fontSize: headline3Size,
      color: AppColors.black,
      fontWeight: FontWeight.w500,
    ),
    headlineMedium: TextStyle(
      fontFamily: AppFonts.DINRoundPro,
      fontSize: headline4Size,
      color: AppColors.black,
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: TextStyle(
      fontFamily: AppFonts.DINRoundPro,
      fontSize: headline5Size,
      color: AppColors.black,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: TextStyle(
      fontFamily: AppFonts.DINRoundPro,
      fontSize: headline6Size,
      color: AppColors.black,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      fontFamily: AppFonts.DINRoundPro,
      fontSize: subtile1Size,
      color: AppColors.black,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      fontFamily: AppFonts.DINRoundPro,
      fontSize: subtile2Size,
      color: AppColors.black,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: TextStyle(
      fontFamily: AppFonts.DINRoundPro,
      fontSize: body1Size,
      color: AppColors.grey,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontFamily: AppFonts.DINRoundPro,
      fontSize: body2Size,
      color: AppColors.black,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(
      fontFamily: AppFonts.DINRoundPro,
      fontSize: buttonSize,
      color: AppColors.white,
      fontWeight: FontWeight.w600,
    ),
    bodySmall: TextStyle(
      fontFamily: AppFonts.DINRoundPro,
      fontSize: caption,
      color: AppColors.black,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      fontFamily: AppFonts.DINRoundPro,
      fontSize: overline,
      color: AppColors.black,
      fontWeight: FontWeight.w400,
    ),
  );

  static const TextTheme mobileTextThemeDark = TextTheme(
    displayLarge: TextStyle(
      fontFamily: AppFonts.DINRoundPro,
      fontSize: headline1Size,
      color: AppColors.white,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontFamily: AppFonts.DINRoundPro,
      fontSize: headline2Size,
      color: AppColors.white,
      fontWeight: FontWeight.w600,
    ),
    displaySmall: TextStyle(
      fontFamily: AppFonts.DINRoundPro,
      fontSize: headline3Size,
      color: AppColors.white,
      fontWeight: FontWeight.w500,
    ),
    headlineMedium: TextStyle(
      fontFamily: AppFonts.DINRoundPro,
      fontSize: headline4Size,
      color: AppColors.white,
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: TextStyle(
      fontFamily: AppFonts.DINRoundPro,
      fontSize: headline5Size,
      color: AppColors.white,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: TextStyle(
      fontFamily: AppFonts.DINRoundPro,
      fontSize: headline6Size,
      color: AppColors.lightGrey,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      fontFamily: AppFonts.DINRoundPro,
      fontSize: subtile1Size,
      color: AppColors.white,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      fontFamily: AppFonts.DINRoundPro,
      fontSize: subtile2Size,
      color: AppColors.lightGrey,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: TextStyle(
      fontFamily: AppFonts.DINRoundPro,
      fontSize: body1Size,
      color: AppColors.lightGrey,
      height: 1.35,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontFamily: AppFonts.DINRoundPro,
      fontSize: body2Size,
      color: AppColors.white,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(
      fontFamily: AppFonts.DINRoundPro,
      fontSize: buttonSize,
      color: AppColors.white,
      fontWeight: FontWeight.w600,
    ),
    bodySmall: TextStyle(
      fontFamily: AppFonts.DINRoundPro,
      fontSize: caption,
      color: AppColors.white,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      fontFamily: AppFonts.DINRoundPro,
      fontSize: overline,
      color: AppColors.white,
      fontWeight: FontWeight.w400,
    ),
  );
}
