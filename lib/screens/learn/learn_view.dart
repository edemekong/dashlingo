import 'package:flutter/material.dart';
import 'package:flutterfairy/components/scaffold.dart';
import 'package:flutterfairy/screens/learn/learn_state.dart';
import 'package:flutterfairy/screens/learn/pages/quiz_page.dart';
import 'package:flutterfairy/screens/learn/pages/setup_to_learn.dart';
import 'package:provider/provider.dart';

class LearnView extends StatelessWidget {
  const LearnView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: PageView(
        children: const [
          // SetUpToLearn(),
          QuizPage(),
        ],
      ),
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
