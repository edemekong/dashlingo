import 'package:dashlingo/UI/screens/lessons/widgets/answer_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/paragraph/paragraph_card.dart';
import '../learn_play_state.dart';

class QuestionBoard extends StatelessWidget {
  final void Function(int index) onTapFill;
  final QuizState quizState;

  const QuestionBoard({
    Key? key,
    required this.quizState,
    required this.onTapFill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LearnPlayState>();

    return ParagraphCard(
      paragraphs: state.learn.content,
      scrollToPosition: (Offset offset) {},
      state: quizState,
      onTapFill: onTapFill,
      style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.w400),
      codeStyle: Theme.of(context).textTheme.bodyText2,
    );
  }
}
