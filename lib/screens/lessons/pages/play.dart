import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/src/sizing_information.dart';

import '../../../components/display_image.dart';
import '../../../components/texts.dart';
import '../../../constants/images_path.dart';
import '../../../models/learn/learn.dart';
import '../../../theme/spaces.dart';
import '../learn_play_state.dart';
import '../widgets/answer_card.dart';
import '../widgets/boards.dart';

class PlayPage extends StatelessWidget {
  const PlayPage({Key? key, required this.padding, required this.width, required this.info}) : super(key: key);

  final double padding;
  final double? width;
  final SizingInformation info;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LearnPlayState>();
    final Learn learn = state.learn;

    return Expanded(
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: padding),
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpaces.elementSpacing),
                DashTexts.headingSmall(learn.title, context),
                const SizedBox(height: AppSpaces.elementSpacing * 1.5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        right: AppSpaces.elementSpacing * 0.5,
                        bottom: AppSpaces.elementSpacing,
                      ),
                      child: SizedBox(
                        width: 110,
                        child: DisplayImage(url: ImagePaths.dash1),
                      ),
                    ),
                    if (info.isMobile) ...[
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(AppSpaces.elementSpacing),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: AppSpaces.defaultBorderRadiusTextField,
                            border: Border.all(
                              width: 1.5,
                              color: Theme.of(context).dividerColor,
                            ),
                          ),
                          child: DashTexts.subHeading(
                            learn.instruction,
                            context,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ] else ...[
                      Container(
                        padding: const EdgeInsets.all(AppSpaces.elementSpacing),
                        constraints: BoxConstraints(
                          maxWidth: width == null ? 400 : width! * 0.5,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: AppSpaces.defaultBorderRadiusTextField.copyWith(bottomLeft: Radius.zero),
                          border: Border.all(
                            width: 1.5,
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                        child: DashTexts.subHeading(
                          learn.instruction,
                          context,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: AppSpaces.elementSpacing),
                Container(
                  constraints: const BoxConstraints(
                    minHeight: 80,
                  ),
                  padding: const EdgeInsets.all(AppSpaces.elementSpacing),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: AppSpaces.defaultBorderRadius,
                    border: Border.all(
                      width: 1.5,
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                  child: QuestionBoard(
                    onTapFill: (int index) {},
                    quizState: !state.validate
                        ? QuizState.non
                        : (state.correctAnswerIds.contains(state.selectedAnswer?.id)
                            ? QuizState.correct
                            : QuizState.wrong),
                  ),
                ),
                const SizedBox(height: AppSpaces.elementSpacing),
                ...List.generate(
                  learn.answers.length,
                  (index) {
                    final bool selected =
                        state.selectedAnswer != null && state.selectedAnswer?.id == state.answers[index].id;

                    final bool isCorrect = state.validate &&
                        state.selectedAnswer != null &&
                        state.correctAnswerIds.contains(state.answers[index].id);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpaces.elementSpacing),
                      child: IgnorePointer(
                        ignoring: state.validate,
                        child: DashAnswerCard(
                          answer: learn.answers[index],
                          state: (isCorrect ? QuizState.correct : (selected ? QuizState.selected : QuizState.non)),
                          index: index,
                          onAnswer: (Answer answer) {
                            state.onSelectAnswer(answer);
                          },
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: kToolbarHeight),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
