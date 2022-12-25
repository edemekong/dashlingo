import 'package:flutter/material.dart';
import 'package:dashlingo/components/paragraph/widgets/image_card.dart';
import 'package:dashlingo/models/learn/paragraph.dart';
import 'package:dashlingo/components/paragraph/widgets/code_card.dart';
import 'package:dashlingo/components/paragraph/widgets/seperator_card.dart';
import 'package:dashlingo/components/paragraph/widgets/text_card.dart';

class ParagraphCard extends StatefulWidget {
  final List<Paragraph> paragraphs;
  final Function(Offset) scrollToPosition;
  final TextStyle? style;
  final TextStyle? codeStyle;

  final double seperatorSize;

  const ParagraphCard({
    super.key,
    required this.paragraphs,
    required this.scrollToPosition,
    this.style,
    this.seperatorSize = 5,
    this.codeStyle,
  });

  @override
  State<ParagraphCard> createState() => _ParagraphCardState();
}

class _ParagraphCardState extends State<ParagraphCard> {
  List<Paragraph> paragraphs = [];

  @override
  void initState() {
    super.initState();

    paragraphs = widget.paragraphs;
  }

  @override
  Widget build(BuildContext context) {
    paragraphs.sort((a, b) => a.index.compareTo(b.index));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final Paragraph paragraph in paragraphs) ...[
          if (paragraph.type == ParagraphType.text.name) ...[
            TextCard(
              paragraph: paragraph,
              style: widget.style,
              onTapText: (type, context, {Offset? offset}) {
                if (type == TextType.text && offset != null) {
                  widget.scrollToPosition(offset);
                }
              },
            ),
          ],
          if (paragraph.type == ParagraphType.seperator.name) ...[
            SeperatorCard(
              paragraph: paragraph,
              size: widget.seperatorSize,
            ),
          ],
          if (paragraph.type == ParagraphType.image.name) ...[
            ImageCard(
              paragraph: paragraph,
            ),
          ],
          if ([ParagraphType.code.name, ParagraphType.output].contains(paragraph.type)) ...[
            CodeCard(
              paragraph: paragraph,
              style: widget.codeStyle,
            ),
          ],
        ],
      ],
    );
  }
}
