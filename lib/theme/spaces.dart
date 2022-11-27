import 'package:flutterfairy/theme/colors.dart';
import 'package:flutter/material.dart';

class AppSpaces {
  static const double cardPadding = 35;
  static const double webWidth = 1080;
  static const double elementSpacing = cardPadding * 0.5;
  static const defaultBorderRadius = BorderRadius.only(
    topLeft: Radius.circular(14),
    topRight: Radius.circular(14),
    bottomLeft: Radius.circular(14),
    bottomRight: Radius.circular(14),
  );

  static const defaultCircularRadius = BorderRadius.only(
    topLeft: Radius.circular(999),
    topRight: Radius.circular(999),
    bottomLeft: Radius.circular(999),
    bottomRight: Radius.circular(999),
  );

  static const double cardOutlineWidth = 0.3;

  static const OutlineInputBorder outLineBorder = OutlineInputBorder(
    borderRadius: defaultBorderRadius,
    borderSide: BorderSide(color: AppColors.mediumGrey, width: cardOutlineWidth),
  );

  static const OutlineInputBorder disabledOutLineBorder = OutlineInputBorder(
    borderRadius: defaultBorderRadius,
    borderSide: BorderSide(color: AppColors.white, width: cardOutlineWidth),
  );
  static const OutlineInputBorder errorLineBorder = OutlineInputBorder(
    borderRadius: defaultBorderRadius,
    borderSide: BorderSide(color: AppColors.red, width: cardOutlineWidth + 0.5),
  );
}
