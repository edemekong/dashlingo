import 'package:flutter/material.dart';

import '../../../components/texts.dart';
import '../../../models/learn/learn.dart';
import '../../../theme/colors.dart';
import '../../../theme/spaces.dart';

enum QuizState { non, correct, selected, wrong, disabled }

class DashAnswerCard extends StatelessWidget {
  final Function(Answer) onAnswer;
  final Answer answer;
  final int index;
  final QuizState state;
  const DashAnswerCard({
    Key? key,
    required this.index,
    required this.state,
    required this.answer,
    required this.onAnswer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final disabled = [QuizState.disabled].contains(state);
    final non = [QuizState.non].contains(state);

    final correct = [QuizState.correct].contains(state);
    final wrong = [QuizState.wrong].contains(state);

    final cardColor = state == QuizState.selected
        ? Theme.of(context).primaryColor
        : correct
            ? AppColors.green
            : (wrong
                ? Theme.of(context).errorColor
                : (disabled || non)
                    ? Theme.of(context).dividerColor
                    : Theme.of(context).primaryColor);
    return InkWell(
      borderRadius: AppSpaces.defaultBorderRadius,
      onTap: state == QuizState.disabled
          ? null
          : () {
              onAnswer(answer);
            },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(AppSpaces.elementSpacing),
        decoration: BoxDecoration(
          color: (disabled || non && !(state == QuizState.selected))
              ? Theme.of(context).backgroundColor
              : isLight
                  ? Theme.of(context).backgroundColor
                  : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            width: 1.5,
            color: cardColor,
          ),
          boxShadow: [
            BoxShadow(
              color: cardColor,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: DashTexts.subHeading(
                  '${index + 1}',
                  context,
                  color: Theme.of(context).backgroundColor,
                ),
              ),
            ),
            const SizedBox(width: AppSpaces.elementSpacing),
            Expanded(
              child: DashTexts.subHeading(
                answer.content,
                context,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
