import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                        EdTexts.headingSmall("Choose the correct answers", context),
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
                              child: EdTexts.bodyText(
                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
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
                          padding: const EdgeInsets.all(AppSpaces.elementSpacing * 0.5),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: AppSpaces.defaultBorderRadius,
                            border: Border.all(
                              width: 1.5,
                              color: Theme.of(context).dividerColor,
                            ),
                          ),
                        ),
                        const Divider(height: AppSpaces.cardPadding),

                        // const SizedBox(height: AppSpaces.cardPadding),
                        ...List.generate(
                          3,
                          (index) => Padding(
                            padding: const EdgeInsets.only(bottom: AppSpaces.elementSpacing),
                            child: EdQuizCard(
                              state: index == 1 ? QuizState.non : QuizState.non,
                              index: index,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // const SizedBox(height: AppSpaces.cardPadding),
            QuizBottomNav(
              padding: padding,
              state: QuizBottomNavState.initial,
            ),
          ],
        );
      }),
    );
  }
}

enum QuizBottomNavState { initial, correct, wrong, skip, login }

class QuizBottomNav extends StatelessWidget {
  final QuizBottomNavState state;
  const QuizBottomNav({
    Key? key,
    required this.padding,
    required this.state,
  }) : super(key: key);

  final double padding;

  @override
  Widget build(BuildContext context) {
    final initial = [QuizBottomNavState.initial].contains(state);
    final correct = [QuizBottomNavState.correct].contains(state);
    final wrong = [QuizBottomNavState.wrong].contains(state);

    final showLine = [QuizBottomNavState.wrong, QuizBottomNavState.correct].contains(state);

    return Column(
      children: [
        if (!showLine) ...[
          Divider(
            thickness: 1.5,
            height: 0,
            color: Theme.of(context).dividerColor,
          ),
        ],
        Container(
          padding: EdgeInsets.symmetric(horizontal: padding),
          color: correct ? AppColors.lightGreen : (wrong ? AppColors.lightRed : Theme.of(context).backgroundColor),
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: AppSpaces.elementSpacing),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (showLine) ...[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColors.white,
                          child: Icon(
                            correct ? Icons.check_rounded : Icons.close_rounded,
                            size: 30,
                            color: correct ? AppColors.green : AppColors.red,
                          ),
                        ),
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
                                "Print('Hello, world')",
                                context,
                                color: AppColors.red,
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ],
                  const Spacer(),
                  EdButton(
                    title: showLine ? "Continue" : 'Check',
                    background: correct ? AppColors.green : (wrong ? AppColors.red : Theme.of(context).dividerColor),
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
}

enum QuizState { non, correct, selected, wrong, disabled }

class EdQuizCard extends StatelessWidget {
  final int index;
  final QuizState state;
  const EdQuizCard({
    Key? key,
    required this.index,
    required this.state,
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
      onTap: state == QuizState.disabled ? null : () {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(AppSpaces.elementSpacing),
        decoration: BoxDecoration(
          color: (disabled && !(state == QuizState.selected))
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
            EdTexts.subHeading(
              'Flutter is useful to build beautiful web applications.',
              context,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
