import 'package:dashlingo/UI/components/paragraph/paragraph_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../theme/spaces.dart';
import '../learn_play_state.dart';

class LearnPage extends StatelessWidget {
  final double padding;
  final double? width;

  const LearnPage({super.key, required this.padding, this.width});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LearnPlayState>();

    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: padding,
            vertical: AppSpaces.cardPadding,
          ),
          width: width,
          child: Container(
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
            child: ParagraphCard(
              paragraphs: state.learn.content,
              scrollToPosition: (Offset offset) {},
              onTapFill: (int index) {},
            ),
          ),
        ),
      ),
    );
  }
}
