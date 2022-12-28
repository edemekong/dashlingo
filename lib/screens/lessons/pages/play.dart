import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/display_image.dart';
import '../../../components/texts.dart';
import '../../../constants/images_path.dart';
import '../../../models/learn/learn.dart';
import '../../../theme/spaces.dart';
import '../learn_play_state.dart';
import '../widgets/answer_card.dart';
import '../widgets/boards.dart';

class PlayPage extends StatelessWidget {
  const PlayPage({
    Key? key,
    required this.padding,
    required this.width,
  }) : super(key: key);

  final double padding;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LearnPlayState>();
    final Learn learn = state.learn;

    return Expanded(
      child: Center(
        child: SingleChildScrollView(
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
                        right: AppSpaces.elementSpacing,
                        bottom: AppSpaces.elementSpacing,
                      ),
                      child: SizedBox(
                        width: 100,
                        child: DisplayImage(url: ImagePaths.dash1),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(AppSpaces.elementSpacing),
                      constraints: const BoxConstraints(
                        maxWidth: 250,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: AppSpaces.defaultBorderRadiusTextField.copyWith(topLeft: Radius.zero),
                        border: Border.all(
                          width: 1.5,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      child: DashTexts.subHeadingSmall(
                        learn.instruction,
                        context,
                        fontWeight: FontWeight.w700,
                        family: 'Courier New',
                      ),
                    ),
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
                  child: const QuestionBoard(),
                ),
                const SizedBox(height: AppSpaces.elementSpacing),
                ...List.generate(
                  learn.answers.length,
                  (index) {
                    final bool selected =
                        state.selectedAnswer != null && state.selectedAnswer?.id == state.answers[index].id;

                    final bool isCorrect = state.validate &&
                        state.selectedAnswer != null &&
                        state.correctAnswerId == state.answers[index].id;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpaces.elementSpacing),
                      child: IgnorePointer(
                        ignoring: state.validate,
                        child: EdAnswerCard(
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
