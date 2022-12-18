import 'package:flutter/material.dart';
import 'package:dashlingo/components/paragraph/widgets/image_card.dart';
import 'package:dashlingo/models/lesson/lesson.dart';
import 'package:dashlingo/models/lesson/paragraph.dart';
import 'package:dashlingo/components/paragraph/widgets/code_card.dart';
import 'package:dashlingo/components/paragraph/widgets/seperator_card.dart';
import 'package:dashlingo/components/paragraph/widgets/text_card.dart';

class ParagraphCard extends StatefulWidget {
  final Lesson lesson;
  final Function(Offset) scrollToPosition;
  const ParagraphCard({super.key, required this.lesson, required this.scrollToPosition});

  @override
  State<ParagraphCard> createState() => _ParagraphCardState();
}

class _ParagraphCardState extends State<ParagraphCard> {
  List<Paragraph> paragraphs = [];

  @override
  void initState() {
    super.initState();

    paragraphs = widget.lesson.paragraphs;
  }

  @override
  Widget build(BuildContext context) {
    paragraphs.sort((a, b) => a.index.compareTo(b.index));

    return Column(
      children: [
        for (final Paragraph paragraph in paragraphs) ...[
          if (paragraph.type == ParagraphType.text.name) ...[
            TextCard(
              paragraph: paragraph,
              onTapText: (type, context, {Offset? offset}) {
                if (type == TextType.text && offset != null) {
                  widget.scrollToPosition(offset);
                }
              },
            ),
          ],
          if (paragraph.type == ParagraphType.seperator.name) ...[
            SeperatorCard(paragraph: paragraph),
          ],
          if (paragraph.type == ParagraphType.image.name) ...[
            ImageCard(paragraph: paragraph),
          ],
          if (paragraph.type == ParagraphType.code.name) ...[
            CodeCard(paragraph: paragraph),
          ],
        ],
      ],
    );
  }
}
