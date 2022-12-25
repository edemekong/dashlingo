import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/button.dart';
import '../../../components/texts.dart';
import '../../../theme/colors.dart';
import '../../../theme/spaces.dart';
import '../learn_play_state.dart';

class QuizBottomNav extends StatelessWidget {
  const QuizBottomNav({Key? key, required this.padding, required, required this.isMobile}) : super(key: key);

  final double padding;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LearnPlayState>();

    final bool correct = state.validate && state.correctAnswerId == state.selectedAnswer?.id;
    final bool wrong = state.validate && state.correctAnswerId != state.selectedAnswer?.id;
    final bool isLearn = state.learn.learnType == 'learn';

    final bool isNext = correct || wrong;
    final isLight = Theme.of(context).brightness == Brightness.light;

    final bool showLine = !state.validate;

    return Column(
      children: [
        if (showLine) ...[
          Divider(
            thickness: 1.5,
            height: 0,
            color: Theme.of(context).dividerColor,
          ),
        ],
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(
            horizontal: padding,
          ),
          color: correct
              ? (isLight ? AppColors.lightGreen : Theme.of(context).cardColor)
              : (wrong
                  ? (isLight ? AppColors.lightRed : Theme.of(context).cardColor)
                  : Theme.of(context).backgroundColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: AppSpaces.elementSpacing),
              if (isNext && isMobile) ...[
                result(correct, context, wrong, state),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (isNext && !isMobile) ...[
                    Expanded(
                      child: result(correct, context, wrong, state),
                    ),
                  ] else ...[
                    const Spacer(),
                  ],
                  DashButton(
                    title: isNext || isLearn ? "Continue" : 'Check',
                    onPressed: state.selectedAnswer == null
                        ? null
                        : () {
                            state.onValidate();
                          },
                    background: correct
                        ? AppColors.green
                        : (wrong
                            ? AppColors.red
                            : state.selectedAnswer != null
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).dividerColor),
                  ),
                ],
              ),
              const SizedBox(height: AppSpaces.elementSpacing),
            ],
          ),
        ),
      ],
    );
  }

  Row result(bool correct, BuildContext context, bool wrong, LearnPlayState state) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
            radius: 20,
            backgroundColor: isLight ? AppColors.white : (correct ? AppColors.green : AppColors.red),
            child: Text(
              String.fromCharCode((correct ? Icons.check_rounded : Icons.close_rounded).codePoint),
              style: TextStyle(
                inherit: false,
                color: isLight ? (correct ? AppColors.green : AppColors.red) : Theme.of(context).cardColor,
                fontSize: 30,
                fontWeight: FontWeight.w900,
                fontFamily: (correct ? Icons.check_rounded : Icons.close_rounded).fontFamily,
                package: (correct ? Icons.check_rounded : Icons.close_rounded).fontPackage,
              ),
            )),
        const SizedBox(width: AppSpaces.elementSpacing),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DashTexts.callout(
                correct ? "Nice!" : "Correct solution:",
                context,
                color: correct ? AppColors.green : AppColors.red,
                fontWeight: FontWeight.w600,
              ),
              if (wrong) ...[
                const SizedBox(height: AppSpaces.elementSpacing * 0.25),
                DashTexts.bodyText(
                  state.correctAnswer?.content ?? "",
                  context,
                  color: AppColors.red,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
