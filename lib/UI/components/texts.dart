import 'package:flutter/material.dart';

class DashTexts {
  DashTexts._();
  static Widget headingBig(String text, BuildContext context, {Color? color, FontWeight? fontWeight}) => Text(text,
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: color,
            height: 1.1,
            fontWeight: fontWeight,
          ));

  static Widget headingMedium(String text, BuildContext context,
          {Color? color, bool center = false, FontWeight? fontWeight}) =>
      Text(
        text,
        textAlign: center ? TextAlign.center : TextAlign.start,
        style: Theme.of(context).textTheme.displayMedium?.copyWith(color: color, fontWeight: fontWeight),
      );

  static Widget headingSmall(
    String text,
    BuildContext context, {
    Color? color,
    TextOverflow? overflow,
    int? maxLines,
    FontWeight? fontWeight,
    bool center = false,
  }) =>
      Text(text,
          overflow: overflow,
          maxLines: maxLines,
          textAlign: center ? TextAlign.center : TextAlign.start,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: color,
                height: 1.1,
                fontWeight: fontWeight,
              ));

  static Widget subHeading(String text, BuildContext context,
          {Color? color,
          TextOverflow? overflow,
          int? maxLines,
          FontWeight? fontWeight,
          bool center = false,
          String? fontFamily}) =>
      Text(
        text,
        overflow: overflow,
        textAlign: center ? TextAlign.center : TextAlign.start,
        maxLines: maxLines,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: color, fontWeight: fontWeight, fontFamily: fontFamily),
      );

  static Widget subHeadingSmall(String text, BuildContext context,
          {Color? color,
          TextOverflow? overflow,
          int? maxLines,
          FontWeight? fontWeight,
          bool center = false,
          String? family}) =>
      Text(
        text,
        overflow: overflow,
        textAlign: center ? TextAlign.center : TextAlign.start,
        maxLines: maxLines,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: color,
              fontWeight: fontWeight,
              fontFamily: family,
            ),
      );

  static Widget callout(String text, BuildContext context,
          {Color? color,
          int? maxLines,
          TextOverflow? overflow,
          FontWeight? fontWeight,
          bool center = false,
          String? family}) =>
      Text(
        text,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: center ? TextAlign.center : TextAlign.start,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: color,
              height: 1.2,
              fontWeight: fontWeight,
              fontFamily: family,
            ),
      );

  ///[footnote], use for links such as “show more…”, terms and conidtion, privacy etc (an additional piece of information printed at the bottom of a page.).
  static Widget footnote(String text, BuildContext context,
          {Color? color, int? maxLines, TextOverflow? overflow, FontWeight? fontWeight, bool center = false}) =>
      Text(
        text,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: center ? TextAlign.center : TextAlign.start,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: color, fontWeight: fontWeight),
      );

  static Widget bodyText(String text, BuildContext context,
          {Color? color, int? maxLines, TextOverflow? overflow, bool center = false, FontWeight? fontWeight}) =>
      Text(text,
          textAlign: center ? TextAlign.center : TextAlign.start,
          overflow: overflow,
          maxLines: maxLines,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: color,
                fontWeight: fontWeight,
              ));

  static Widget button(String text, BuildContext context, {Color? color}) =>
      Text(text, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: color));

  static Widget caption(String text, BuildContext context,
          {Color? color, int? maxLines, TextOverflow? overflow, FontWeight? fontWeight, bool center = false}) =>
      Text(
        text,
        textAlign: center ? TextAlign.center : TextAlign.start,
        maxLines: maxLines,
        overflow: overflow,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color, fontWeight: fontWeight ?? FontWeight.w400),
      );
}
