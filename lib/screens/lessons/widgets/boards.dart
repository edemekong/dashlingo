import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/paragraph/paragraph_card.dart';
import '../learn_play_state.dart';

class QuestionBoard extends StatelessWidget {
  const QuestionBoard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LearnPlayState>();

    return ParagraphCard(
      paragraphs: state.learn.content,
      scrollToPosition: (Offset offset) {},
      style: Theme.of(context).textTheme.bodyText1,
      codeStyle: Theme.of(context).textTheme.bodyText2,
    );
  }
}
