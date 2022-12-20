import 'package:flutter/material.dart';
import 'package:dashlingo/components/scaffold.dart';
import 'package:dashlingo/components/stepper.dart';
import 'package:dashlingo/screens/lessons/lesson/lesson_state.dart';
import 'package:dashlingo/screens/lessons/quiz/quiz_page.dart';
import 'package:dashlingo/theme/spaces.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LessonView extends StatelessWidget {
  const LessonView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LearnState>();

    return AppScaffold(
      body: ResponsiveBuilder(builder: (context, info) {
        return Column(
          children: [
            const SizedBox(height: AppSpaces.elementSpacing),
            SizedBox(
              width: info.localWidgetSize.width * 0.9,
              child: Row(
                children: [
                  // const CloseButton(),
                  // const SizedBox(width: AppSpaces.elementSpacing),
                  Expanded(
                    child: StepperProgressBar(
                      count: (((state.currentPageIndex + 1) / 3) * 100).toInt(),
                      width: info.localWidgetSize.width * 0.9,
                      height: 15,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                onPageChanged: state.onPageChanged,
                controller: state.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  for (var i = 0; i < state.quizes.length; i++) ...[
                    QuizPageWidget(
                      quiz: state.quizes[i],
                      onNext: state.onNext,
                    ),
                  ],
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class LessonViewWidget extends StatelessWidget {
  const LessonViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LearnState(),
      child: const LessonView(),
    );
  }
}
