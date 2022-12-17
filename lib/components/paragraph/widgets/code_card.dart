// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutterfairy/constants/font_family.dart';
import 'package:flutterfairy/models/lesson/paragraph.dart';
import 'package:flutterfairy/theme/spaces.dart';

class CodeCard extends StatelessWidget {
  final Paragraph paragraph;
  final bool output;
  const CodeCard({super.key, required this.paragraph, this.output = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpaces.elementSpacing),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: AppSpaces.defaultBorderRadius,
      ),
      child: ClipRRect(
        borderRadius: AppSpaces.defaultBorderRadiusTextField,
        child: Stack(
          children: [
            if (output)
              ...[]
            else ...[
              HighlightView(
                paragraph.content,
                language: 'dart',
                theme: const {
                  'root': TextStyle(backgroundColor: Colors.transparent, color: Colors.transparent),
                  'comment': TextStyle(color: Color(0xff969896)),
                  'meta': TextStyle(color: Color(0xff969896)),
                  'variable': TextStyle(color: Color(0xffdf5000)),
                  'template-variable': TextStyle(color: Color(0xffdf5000)),
                  'strong': TextStyle(color: Color(0xffdf5000)),
                  'emphasis': TextStyle(color: Color(0xffdf5000)),
                  'quote': TextStyle(color: Color(0xffdf5000)),
                  'keyword': TextStyle(color: Color(0xffd73a49)),
                  'selector-tag': TextStyle(color: Color(0xffd73a49)),
                  'type': TextStyle(color: Color(0xffd73a49)),
                  'literal': TextStyle(color: Color(0xff0086b3)),
                  'symbol': TextStyle(color: Color(0xff0086b3)),
                  'bullet': TextStyle(color: Color(0xff0086b3)),
                  'attribute': TextStyle(color: Color(0xff0086b3)),
                  'section': TextStyle(color: Color(0xff63a35c)),
                  'name': TextStyle(color: Color(0xff63a35c)),
                  'tag': TextStyle(color: Color(0xff333333)),
                  'title': TextStyle(color: Color(0xff6f42c1)),
                  'attr': TextStyle(color: Color(0xff6f42c1)),
                  'selector-id': TextStyle(color: Color(0xff6f42c1)),
                  'selector-class': TextStyle(color: Color(0xff6f42c1)),
                  'selector-attr': TextStyle(color: Color(0xff6f42c1)),
                  'selector-pseudo': TextStyle(color: Color(0xff6f42c1)),
                  'addition': TextStyle(color: Color(0xff55a532), backgroundColor: Color(0xffeaffea)),
                  'deletion': TextStyle(color: Color(0xffbd2c00), backgroundColor: Color(0xffffecec)),
                  'number': TextStyle(color: Color(0xff005cc5)),
                  'string': TextStyle(color: Color(0xff032f62)),
                },
                padding: const EdgeInsets.all(AppSpaces.elementSpacing),
                textStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontFamily: COURIER_NEW,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
            Positioned(
              right: 0,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.copy, size: 18),
              ),
            )
          ],
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
