// import 'package:flutter/material.dart';

// import '../../../../src/components/texts.dart';
// import '../../../../data/models/learn/learn.dart';
// import '../../../../src/theme/colors.dart';
// import '../../../../src/theme/spaces.dart';
// import 'answer_card.dart';

// class DashFillAnswerCard extends StatelessWidget {
//   final Function(Answer) onAnswer;
//   final Answer answer;
//   final int index;
//   final QuizState state;
//   const DashFillAnswerCard({
//     Key? key,
//     required this.index,
//     required this.state,
//     required this.answer,
//     required this.onAnswer,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final isLight = Theme.of(context).brightness == Brightness.light;
//     final disabled = [QuizState.disabled].contains(state);
//     final non = [QuizState.non].contains(state);

//     final correct = [QuizState.correct].contains(state);
//     final wrong = [QuizState.wrong].contains(state);

//     final cardColor = state == QuizState.selected
//         ? Theme.of(context).primaryColor
//         : correct
//             ? AppColors.green
//             : (wrong
//                 ? Theme.of(context).colorScheme.error
//                 : (disabled || non)
//                     ? Theme.of(context).dividerColor
//                     : Theme.of(context).primaryColor);
//     return InkWell(
//       borderRadius: AppSpaces.defaultBorderRadius,
//       onTap: disabled ? null : () => onAnswer(answer),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 150),
//         padding: const EdgeInsets.all(AppSpaces.elementSpacing),
//         decoration: BoxDecoration(
//           color: (disabled || non && !(state == QuizState.selected))
//               ? Theme.of(context).colorScheme.background
//               : isLight
//                   ? Theme.of(context).colorScheme.background
//                   : Theme.of(context).cardColor,
//           borderRadius: BorderRadius.circular(18),
//           border: Border.all(width: 1.5, color: cardColor),
//           boxShadow: [
//             BoxShadow(
//               color: cardColor,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: DashTexts.bodyText(
//           answer.content,
//           context,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }
// }
