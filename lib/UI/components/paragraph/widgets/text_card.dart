import 'package:flutter/material.dart';
import 'package:dashlingo/UI/theme/colors.dart';
import 'package:linkify/linkify.dart';

import 'package:dashlingo/UI/components/texts.dart';
import 'package:dashlingo/data/models/learn/paragraph.dart';
import 'package:dashlingo/UI/theme/spaces.dart';

import '../../dash_text/formatted_texts.dart';
import '../../widget_offset.dart';

enum TextType { url, hyperLink, text }

class TextCard extends StatefulWidget {
  final Function(TextType, String, {Offset offset}) onTapText;
  final Paragraph paragraph;
  final TextStyle? style;

  const TextCard({
    Key? key,
    required this.paragraph,
    required this.onTapText,
    this.style,
  }) : super(key: key);

  @override
  State<TextCard> createState() => _TextCardState();
}

class _TextCardState extends State<TextCard> {
  bool isHoverTitle = false;

  Offset? offset;

  void onHoverTitle(bool v) {
    setState(() {
      isHoverTitle = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    final linkifiers = [...defaultLinkifiers, const CustomLinkifier()];
    final elements = linkify(widget.paragraph.content, linkifiers: linkifiers);
    final style = widget.style ??
        Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w400,
              height: 1.35,
            );
    TextSpan textSpan = TextSpan(
      children: List.generate(elements.length, (index) {
        final element = elements[index];

        if (element is TextElement) {
          return TextSpan(
            text: element.text,
          );
        }

        if (element is LinkableElement) {
          return TextSpan(
            text: element.url,
            style: style?.copyWith(
              fontWeight: FontWeight.w400,
              height: 1.35,
              color: Theme.of(context).primaryColor,
            ),
          );
        }

        if (element is BlankElement) {
          return TextSpan(
            text: element.url,
            style: style?.copyWith(
              fontWeight: FontWeight.w400,
              height: 1.35,
              color: AppColors.red,
            ),
          );
        }

        return TextSpan(text: element.text);
      }),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.paragraph.title != null) ...[
          WidgetOffset(
            onOffsetChanged: (Offset offset) {
              if (this.offset != null) return;
              this.offset = offset;
            },
            child: InkWell(
              onHover: onHoverTitle,
              onTap: () {
                if (offset == null) return;
                widget.onTapText(TextType.text, widget.paragraph.title!, offset: offset!);
              },
              child: DashTexts.headingSmall(
                widget.paragraph.title!,
                context,
                fontWeight: FontWeight.w600,
                color: isHoverTitle ? AppColors.blue : null,
              ),
            ),
          ),
          const SizedBox(height: AppSpaces.elementSpacing * 0.5),
        ],
        RichText(
          softWrap: true,
          text: TextSpan(
            style: style,
            children: [textSpan],
          ),
        ),
      ],
    );
  }
}
