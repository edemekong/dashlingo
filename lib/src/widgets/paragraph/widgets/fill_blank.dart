// import 'package:dashlingo/src/widgets/bounce_animation.dart';
// import 'package:dashlingo/src/widgets/texts.dart';
// import 'package:dashlingo/data/models/learn/paragraph.dart';
// import 'package:dashlingo/src/theme/colors.dart';
// import 'package:dashlingo/src/theme/spaces.dart';
// import 'package:flutter/material.dart';

// import '../../../../UI/screens/lessons/widgets/answer_card.dart';

// class FillInBlanks extends StatelessWidget {
//   final Paragraph paragraph;
//   final QuizState quizState;
//   const FillInBlanks({
//     super.key,
//     required this.paragraph,
//     this.quizState = QuizState.non,
//     required void Function(int index) onTapFill,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final correct = [QuizState.correct].contains(quizState);
//     final wrong = [QuizState.wrong].contains(quizState);

//     final List<String> fill = paragraph.fill;

//     return BounceAnimation(
//       onTap: () {},
//       child: Row(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: List.generate(
//             fill.isEmpty ? 1 : fill.length,
//             (index) {
//               return Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: AppSpaces.elementSpacing * 0.8,
//                   vertical: AppSpaces.elementSpacing * 0.5,
//                 ),
//                 constraints: const BoxConstraints(
//                   minWidth: 50,
//                   minHeight: 30,
//                 ),
//                 color: !correct && !wrong ? Theme.of(context).cardColor : (correct ? AppColors.green : AppColors.red),
//                 child: Center(
//                   child: DashTexts.subHeading(
//                     fill.isEmpty ? '' : fill[index],
//                     context,
//                     fontWeight: correct || wrong ? FontWeight.w600 : FontWeight.w400,
//                     color: !correct && !wrong ? null : AppColors.white,
//                   ),
//                 ),
//               );
//             },
//           )),
//     );
//   }
// }
