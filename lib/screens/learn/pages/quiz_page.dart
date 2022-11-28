import 'package:flutter/material.dart';
import 'package:flutterfairy/components/stepper.dart';
import 'package:flutterfairy/models/quiz.dart';
import 'package:flutterfairy/screens/learn/quiz_page_state.dart';
import 'package:flutterfairy/utils/logs.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:flutterfairy/components/button.dart';
import 'package:flutterfairy/components/display_image.dart';
import 'package:flutterfairy/components/scaffold.dart';
import 'package:flutterfairy/components/texts.dart';
import 'package:flutterfairy/constants/images_path.dart';
import 'package:flutterfairy/theme/colors.dart';
import 'package:flutterfairy/theme/spaces.dart';

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
                        const SizedBox(height: AppSpaces.cardPadding),
                        EdTexts.headingSmall(quiz.title, context),
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
                                width: 80,
                                child: DisplayImage(url: ImagePaths.fairy),
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
                              child: EdTexts.subHeadingSmall(
                                quiz.instruction,
                                context,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpaces.elementSpacing),
                        Container(
                          constraints: const BoxConstraints(
                            maxHeight: 150,
                            minHeight: 100,
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
                          child: const FillAnswerPlayingBoard(),
                        ),
                        const Divider(height: AppSpaces.cardPadding),
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

class FillAnswerPlayingBoard extends StatelessWidget {
  const FillAnswerPlayingBoard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<QuizPageState>();

    final elements = state.quiz.question.content;
    // return Container(child: EdTexts.subHeading(elements, context));

    TextSpan textSpan;

    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);

        textSpan = TextSpan(
          children: List.generate(elements.length, (index) {
            final element = elements[index];
            edPrint(element + index.toString());

            if (element.startsWith("/blank")) {
              // final check = element.url.toLowerCase().startsWith("https://medalla.page.link/");
              return TextSpan(
                text: "Heyyy",
                style: Theme.of(context).textTheme.bodyText1,
              );
            } else {
              return TextSpan(
                text: element,
                style: Theme.of(context).textTheme.subtitle1,
              );
            }
          }),
        );

        final text = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
        );
        text.layout(maxWidth: constraints.maxWidth);

        if (text.didExceedMaxLines) {
          return Column(
            children: [
              RichText(softWrap: true, text: textSpan),
            ],
          );
        } else {
          return RichText(
            softWrap: true,
            text: textSpan,
          );
        }
      },
    );
    return result;
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
                  ],
                  const Spacer(),
                  EdButton(
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EdTexts.callout(
              correct ? "Nice!" : "Correct solution:",
              context,
              color: correct ? AppColors.green : AppColors.red,
              fontWeight: FontWeight.w600,
            ),
            if (wrong) ...[
              const SizedBox(height: AppSpaces.elementSpacing * 0.25),
              EdTexts.bodyText(
                state.correctAnswer?.content ?? "",
                context,
                color: AppColors.red,
              ),
            ],
          ],
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
                child: EdTexts.subHeading(
                  '${index + 1}',
                  context,
                  color: Theme.of(context).backgroundColor,
                ),
              ),
            ),
            const SizedBox(width: AppSpaces.elementSpacing),
            Expanded(
              child: EdTexts.subHeading(
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
