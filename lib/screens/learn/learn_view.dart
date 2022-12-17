import 'package:flutter/material.dart';
import 'package:flutterfairy/components/scaffold.dart';
import 'package:flutterfairy/components/stepper.dart';
import 'package:flutterfairy/screens/learn/learn_state.dart';
import 'package:flutterfairy/screens/learn/pages/quiz_page.dart';
import 'package:flutterfairy/theme/spaces.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LearnView extends StatelessWidget {
  const LearnView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LearnState>();

    return AppScaffold(
      body: ResponsiveBuilder(builder: (context, info) {
        return Column(
          children: [
            const SizedBox(height: AppSpaces.cardPadding),
            StepperProgressBar(
              count: (((state.currentPageIndex + 1) / 3) * 100).toInt(),
              width: info.localWidgetSize.width * 0.8,
              height: 15,
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

class LearnViewWidget extends StatelessWidget {
  const LearnViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LearnState(),
      child: const LearnView(),
    );
  }
}
