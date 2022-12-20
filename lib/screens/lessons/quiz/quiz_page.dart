import 'package:flutter/material.dart';
import 'package:dashlingo/models/lesson/paragraph.dart';
import 'package:dashlingo/models/quiz.dart';
import 'package:dashlingo/screens/lessons/quiz/quiz_page_state.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:dashlingo/components/button.dart';
import 'package:dashlingo/components/display_image.dart';
import 'package:dashlingo/components/scaffold.dart';
import 'package:dashlingo/components/texts.dart';
import 'package:dashlingo/constants/images_path.dart';
import 'package:dashlingo/theme/colors.dart';
import 'package:dashlingo/theme/spaces.dart';

import '../../../components/paragraph/widgets/text_card.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<QuizPageState>();
    final quiz = state.quiz;
    return AppScaffold(
      body: ResponsiveBuilder(builder: (context, info) {
        final double padding = info.localWidgetSize.width / AppSpaces.elementSpacing;
        final width = info.isDesktop ? (info.localWidgetSize.width * 0.8) : null;

        return Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppSpaces.elementSpacing),
                        DashTexts.headingSmall(quiz.title, context),
                        const SizedBox(height: AppSpaces.cardPadding),
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
                              padding: const EdgeInsets.all(AppSpaces.elementSpacing * 0.5),
                              constraints: const BoxConstraints(
                                maxWidth: 250,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: AppSpaces.defaultBorderRadius.copyWith(topLeft: Radius.zero),
                                border: Border.all(
                                  width: 1.5,
                                  color: Theme.of(context).dividerColor,
                                ),
                              ),
                              child: DashTexts.subHeadingSmall(
                                quiz.instruction,
                                context,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpaces.cardPadding),
                        Container(
                          constraints: const BoxConstraints(
                            maxHeight: 120,
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
                          quiz.answers.length,
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
                                  answer: quiz.answers[index],
                                  state:
                                      (isCorrect ? QuizState.correct : (selected ? QuizState.selected : QuizState.non)),
                                  index: index,
                                  onAnswer: (Answer answer) {
                                    state.onSelectAnswer(answer);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            QuizBottomNav(padding: padding, isMobile: info.isMobile),
          ],
        );
      }),
    );
  }
}

class QuestionBoard extends StatelessWidget {
  const QuestionBoard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<QuizPageState>();

    final element = state.quiz.question.content;
    final paragraph = Paragraph(
      id: 'question',
      index: 0,
      content: element,
      type: 'text',
    );

    return TextCard(
      paragraph: paragraph,
      onTapText: (TextType type, String context, {Offset? offset}) {},
    );
  }
}

class QuizBottomNav extends StatelessWidget {
  const QuizBottomNav({Key? key, required this.padding, required, required this.isMobile}) : super(key: key);

  final double padding;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<QuizPageState>();

    final bool correct = state.validate && state.correctAnswerId == state.selectedAnswer?.id;
    final bool wrong = state.validate && state.correctAnswerId != state.selectedAnswer?.id;
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
                    title: isNext ? "Continue" : 'Check',
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

  Row result(bool correct, BuildContext context, bool wrong, QuizPageState state) {
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

enum QuizState { non, correct, selected, wrong, disabled }

class EdAnswerCard extends StatelessWidget {
  final Function(Answer) onAnswer;
  final Answer answer;
  final int index;
  final QuizState state;
  const EdAnswerCard({
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
          borderRadius: AppSpaces.defaultBorderRadius,
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
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizPageWidget extends StatelessWidget {
  final Quiz quiz;
  final Answer? selectedAnswer;
  final Function(Answer) onNext;

  const QuizPageWidget({
    super.key,
    required this.quiz,
    this.selectedAnswer,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuizPageState(quiz, selectedAnswer, onNext),
      child: const QuizPage(),
    );
  }
}
