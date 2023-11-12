// import 'package:dashlingo/src/widgets/paragraph/widgets/fill_blank.dart';
// import 'package:dashlingo/UI/screens/lessons/widgets/answer_card.dart';
// import 'package:dashlingo/src/theme/spaces.dart';
// import 'package:flutter/material.dart';
// import 'package:dashlingo/src/widgets/paragraph/widgets/image_card.dart';
// import 'package:dashlingo/data/models/learn/paragraph.dart';
// import 'package:dashlingo/src/widgets/paragraph/widgets/code_card.dart';
// import 'package:dashlingo/src/widgets/paragraph/widgets/seperator_card.dart';
// import 'package:dashlingo/src/widgets/paragraph/widgets/text_card.dart';

// class ParagraphCard extends StatefulWidget {
//   final List<Paragraph> paragraphs;
//   final QuizState state;
//   final Function(Offset) scrollToPosition;
//   final TextStyle? style;
//   final TextStyle? codeStyle;

//   final double seperatorSize;
//   final void Function(int index) onTapFill;

//   const ParagraphCard({
//     super.key,
//     required this.paragraphs,
//     required this.scrollToPosition,
//     this.style,
//     this.seperatorSize = 5,
//     this.codeStyle,
//     this.state = QuizState.non,
//     required this.onTapFill,
//   });

//   @override
//   State<ParagraphCard> createState() => _ParagraphCardState();
// }

// class _ParagraphCardState extends State<ParagraphCard> {
//   List<Paragraph> paragraphs = [];

//   @override
//   void initState() {
//     super.initState();

//     paragraphs = widget.paragraphs;
//   }

//   @override
//   Widget build(BuildContext context) {
//     paragraphs.sort((a, b) => a.index.compareTo(b.index));

//     return RichText(
//       text: TextSpan(children: [
//         for (final Paragraph paragraph in paragraphs) ...[
//           if (paragraph.type == ParagraphType.text.name) ...[
//             WidgetSpan(
//               alignment: PlaceholderAlignment.middle,
//               child: TextCard(
//                 paragraph: paragraph,
//                 style: widget.style,
//                 onTapText: (type, context, {Offset? offset}) {
//                   if (type == TextType.text && offset != null) {
//                     widget.scrollToPosition(offset);
//                   }
//                 },
//               ),
//             ),
//             const WidgetSpan(child: SizedBox(width: AppSpaces.elementSpacing * 0.25)),
//           ],
//           if (paragraph.type == ParagraphType.seperator.name) ...[
//             WidgetSpan(
//               child: SeperatorCard(
//                 paragraph: paragraph,
//                 size: widget.seperatorSize,
//               ),
//             ),
//           ],
//           if (paragraph.type == ParagraphType.image.name) ...[
//             WidgetSpan(
//               child: ImageCard(
//                 paragraph: paragraph,
//               ),
//             ),
//           ],
//           if ([ParagraphType.code.name, ParagraphType.output].contains(paragraph.type)) ...[
//             WidgetSpan(
//               alignment: PlaceholderAlignment.middle,
//               child: CodeCard(
//                 paragraph: paragraph,
//                 style: widget.codeStyle,
//               ),
//             ),
//           ],
//           if ([ParagraphType.fillInBlanks.name, ParagraphType.fillInMultipleBlanks.name].contains(paragraph.type)) ...[
//             WidgetSpan(
//               alignment: PlaceholderAlignment.middle,
//               child: FillInBlanks(
//                 onTapFill: widget.onTapFill,
//                 paragraph: paragraph,
//                 quizState: widget.state,
//               ),
//             ),
//           ],
//         ],
//       ]),
//     );
//   }
// }
