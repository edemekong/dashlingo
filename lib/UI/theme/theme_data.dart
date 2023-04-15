import 'package:dashlingo/UI/theme/spaces.dart';
import 'package:dashlingo/UI/theme/text_themes.dart';
import 'package:dashlingo/constants/font_family.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

class AppThemeData {
  static ThemeData themeLight = ThemeData(
    fontFamily: AppFonts.DINRoundPro,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.white,
      iconTheme: IconThemeData(
        color: AppColors.cardDark,
        size: 24,
      ),
      toolbarHeight: 47,
    ),
    dividerTheme: const DividerThemeData(color: AppColors.dividerLight, thickness: AppSpaces.cardOutlineWidth),
    colorScheme: const ColorScheme(
      primary: AppColors.primaryColor,
      secondary: AppColors.black,
      onPrimary: AppColors.primaryColor,
      surface: AppColors.white,
      onSurface: AppColors.white,
      background: AppColors.lightBackground,
      brightness: Brightness.light,
      error: AppColors.red,
      onBackground: AppColors.lightBackground,
      onError: AppColors.red,
      onSecondary: AppColors.white,
    ),
    scaffoldBackgroundColor: AppColors.lightBackground,
    primaryColor: AppColors.primaryColor,
    buttonTheme: const ButtonThemeData(
      height: 47,
      splashColor: AppColors.lightGrey,
    ),
    hintColor: AppColors.white,
    indicatorColor: AppColors.white,
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(AppColors.cardDark),
      splashRadius: 16,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.iconLight,
      size: 24,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      showSelectedLabels: false,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      selectedItemColor: AppColors.black,
      unselectedItemColor: AppColors.grey,
      selectedIconTheme: IconThemeData(
        color: AppColors.black,
        size: 28,
      ),
      unselectedIconTheme: IconThemeData(
        color: AppColors.unselectedColorLight,
        size: 28,
      ),
    ),
    splashColor: AppColors.cardDark,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.lightGrey,
      filled: true,
      hintStyle: AppTextThemes.mobileTextThemeLight.bodyLarge,
      iconColor: AppColors.black,
      border: AppSpaces.outLineBorder.copyWith(
        borderSide: const BorderSide(
          width: 1.5,
          color: AppColors.dividerLight,
        ),
      ),
      focusColor: AppColors.white,
      enabledBorder: AppSpaces.outLineBorder.copyWith(
        borderSide: const BorderSide(
          width: 1.5,
          color: AppColors.dividerLight,
        ),
      ),
      errorBorder: AppSpaces.errorLineBorder,
      focusedErrorBorder: AppSpaces.errorLineBorder,
      focusedBorder: AppSpaces.outLineBorder.copyWith(
        borderSide: const BorderSide(
          width: 1.5,
          color: AppColors.dividerLight,
        ),
      ),
      disabledBorder: AppSpaces.disabledOutLineBorder,
      isDense: true,
      contentPadding: const EdgeInsets.all(16),
    ),
    primaryIconTheme: const IconThemeData(
      color: AppColors.black,
      size: 24,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    unselectedWidgetColor: AppColors.unselectedColorLight,
    canvasColor: AppColors.cardLight2,
    cardColor: AppColors.cardLight,
    textTheme: AppTextThemes.mobileTextThemeLight,
    primaryTextTheme: AppTextThemes.mobileTextThemeLight,
    textSelectionTheme: const TextSelectionThemeData(cursorColor: AppColors.blue),
  );

  static ThemeData themeDark = ThemeData(
    fontFamily: AppFonts.DINRoundPro,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.cardLight,
      iconTheme: IconThemeData(
        color: AppColors.white,
        size: 24,
      ),
    ),
    dividerTheme: const DividerThemeData(color: AppColors.dividerDark, thickness: 0.15),
    colorScheme: const ColorScheme(
      primary: AppColors.primaryColor,
      secondary: AppColors.black,
      onPrimary: AppColors.primaryColor,
      surface: AppColors.lightGrey,
      onSurface: AppColors.lightGrey,
      background: AppColors.darkBackground,
      brightness: Brightness.dark,
      error: AppColors.red,
      onBackground: AppColors.darkBackground,
      onError: AppColors.red,
      onSecondary: AppColors.lightGrey,
    ),
    cardColor: AppColors.cardDark,
    scaffoldBackgroundColor: AppColors.black,
    primaryColor: AppColors.primaryColor,
    buttonTheme: const ButtonThemeData(
      height: 47,
      splashColor: AppColors.lightGrey,
    ),
    hintColor: AppColors.white,
    indicatorColor: AppColors.white,
    canvasColor: AppColors.cardDark2,
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(AppColors.cardLight),
      splashRadius: 16,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.white,
      size: 24,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: AppColors.white,
      unselectedItemColor: AppColors.lightGrey,
      unselectedIconTheme: IconThemeData(
        color: AppColors.lightGrey,
        size: 28,
      ),
      selectedIconTheme: IconThemeData(
        color: AppColors.white,
        size: 28,
      ),
    ),
    splashColor: AppColors.lightGrey,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.black,
      filled: true,
      hintStyle: AppTextThemes.mobileTextThemeDark.bodyLarge,
      iconColor: AppColors.white,
      helperStyle: AppTextThemes.mobileTextThemeDark.bodyMedium,
      border: AppSpaces.outLineBorder.copyWith(
        borderSide: const BorderSide(
          width: 1.5,
          color: AppColors.dividerDark,
        ),
      ),
      focusColor: AppColors.white,
      enabledBorder: AppSpaces.outLineBorder.copyWith(
        borderSide: const BorderSide(
          width: 1.5,
          color: AppColors.dividerDark,
        ),
      ),
      errorBorder: AppSpaces.errorLineBorder,
      focusedBorder: AppSpaces.outLineBorder.copyWith(
        borderSide: const BorderSide(
          width: 1.5,
          color: AppColors.dividerDark,
        ),
      ),
      disabledBorder: AppSpaces.disabledOutLineBorder,
      isDense: true,
      contentPadding: const EdgeInsets.all(16),
    ),
    primaryIconTheme: const IconThemeData(
      color: AppColors.white,
      size: 24,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    unselectedWidgetColor: AppColors.unselectedColorDark,
    textTheme: AppTextThemes.mobileTextThemeDark,
    primaryTextTheme: AppTextThemes.mobileTextThemeDark,
    textSelectionTheme: const TextSelectionThemeData(cursorColor: AppColors.blue),
  );
}
