// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:dashlingo/constants/font_family.dart';
import 'package:dashlingo/data/models/learn/paragraph.dart';
import 'package:dashlingo/UI/theme/spaces.dart';

class CodeCard extends StatelessWidget {
  final Paragraph paragraph;
  final TextStyle? style;
  final bool output;
  const CodeCard({super.key, required this.paragraph, this.output = false, this.style});

  @override
  Widget build(BuildContext context) {
    final textStyle = style ?? Theme.of(context).textTheme.bodyText1;
    return Container(
      // margin: const EdgeInsets.only(bottom: AppSpaces.elementSpacing),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: AppSpaces.defaultBorderRadius,
      ),
      child: ClipRRect(
        borderRadius: AppSpaces.defaultBorderRadiusTextField,
        child: HighlightView(
          paragraph.content,
          language: 'dart',
          theme: {
            'root': textStyle!.copyWith(
              backgroundColor: Colors.transparent,
              color: Colors.transparent,
            ),
            'comment': textStyle.copyWith(
              color: const Color(0xff969896),
            ),
            'meta': textStyle.copyWith(color: const Color(0xff969896)),
            'variable': textStyle.copyWith(color: const Color(0xffdf5000)),
            'template-variable': textStyle.copyWith(color: const Color(0xffdf5000)),
            'strong': textStyle.copyWith(color: const Color(0xffdf5000)),
            'emphasis': textStyle.copyWith(color: const Color(0xffdf5000)),
            'quote': textStyle.copyWith(color: const Color(0xffdf5000)),
            'keyword': textStyle.copyWith(color: const Color(0xffd73a49)),
            'selector-tag': textStyle.copyWith(color: const Color(0xffd73a49)),
            'type': textStyle.copyWith(color: const Color(0xffd73a49)),
            'literal': textStyle.copyWith(color: const Color(0xff0086b3)),
            'symbol': textStyle.copyWith(color: const Color(0xff0086b3)),
            'bullet': textStyle.copyWith(color: const Color(0xff0086b3)),
            'attribute': textStyle.copyWith(color: const Color(0xff0086b3)),
            'section': textStyle.copyWith(color: const Color(0xff63a35c)),
            'name': textStyle.copyWith(color: const Color(0xff63a35c)),
            'tag': textStyle.copyWith(color: const Color(0xff333333)),
            'title': textStyle.copyWith(color: const Color(0xff6f42c1)),
            'attr': textStyle.copyWith(color: const Color(0xff6f42c1)),
            'selector-id': textStyle.copyWith(color: const Color(0xff6f42c1)),
            'selector-class': textStyle.copyWith(color: const Color(0xff6f42c1)),
            'selector-attr': textStyle.copyWith(color: const Color(0xff6f42c1)),
            'selector-pseudo': textStyle.copyWith(color: const Color(0xff6f42c1)),
            'addition': textStyle.copyWith(color: const Color(0xff55a532), backgroundColor: const Color(0xffeaffea)),
            'deletion': textStyle.copyWith(color: const Color(0xffbd2c00), backgroundColor: const Color(0xffffecec)),
            'number': textStyle.copyWith(color: const Color(0xff005cc5)),
            'string': textStyle.copyWith(color: const Color(0xff032f62)),
          },
          padding: const EdgeInsets.all(AppSpaces.elementSpacing),
          textStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                fontFamily: COURIER_NEW,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}

class CodeOutputCard extends StatelessWidget {
  const CodeOutputCard({super.key});

  @override
  Widget build(BuildContext context) {
    // linkify(text)
    return Container();
  }
}
