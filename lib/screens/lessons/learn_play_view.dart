import 'package:flutter/material.dart';
import 'package:dashlingo/models/learn/learn.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:dashlingo/components/scaffold.dart';
import 'package:dashlingo/theme/spaces.dart';

import 'learn_play_state.dart';
import 'pages/learn.dart';
import 'pages/play.dart';
import 'widgets/learn_bottom.dart';

class LearnPlayView extends StatelessWidget {
  const LearnPlayView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LearnPlayState>();
    final learn = state.learn;
    return AppScaffold(
      body: ResponsiveBuilder(builder: (context, info) {
        final double padding = info.localWidgetSize.width / AppSpaces.elementSpacing;
        final width = info.isDesktop ? (info.localWidgetSize.width * 0.8) : null;

        return Column(
          children: [
            Builder(builder: (context) {
              if (learn.learnType == 'learn') {
                return LearnPage(
                  padding: padding,
                  width: width,
                );
              }
              return PlayPage(
                padding: padding,
                width: width,
              );
            }),
            QuizBottomNav(
              padding: padding,
              isMobile: info.isMobile,
            ),
          ],
        );
      }),
    );
  }
}

class LearnPlayViewWidget extends StatelessWidget {
  final Learn learn;
  final Answer? selectedAnswer;
  final Function(Answer) onNext;

  const LearnPlayViewWidget({
    super.key,
    required this.learn,
    this.selectedAnswer,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LearnPlayState(learn, selectedAnswer, onNext),
      child: const LearnPlayView(),
    );
  }
}
