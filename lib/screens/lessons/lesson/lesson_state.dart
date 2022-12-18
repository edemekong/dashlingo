import 'package:flutter/material.dart';
import 'package:dashlingo/components/base_state.dart';
import 'package:dashlingo/constants/duration.dart';
import 'package:dashlingo/constants/mock.dart';
import 'package:dashlingo/models/quiz.dart';
import 'package:dashlingo/utils/logs.dart';

class LearnState extends BaseState {
  late PageController pageController;

  int currentPageIndex = 0;
  List<Quiz> quizes = [];

  Map<String, dynamic> answers = {};

  LearnState() {
    pageController = PageController();
    quizes = quizData;
  }

  void onPageChanged(int index) {
    currentPageIndex = index;
    notifyListeners();
  }

  void animateToPage() {
    if ((currentPageIndex + 1) >= quizData.length) return;
    currentPageIndex++;
    notifyListeners();
    pageController.animateToPage(currentPageIndex, duration: fast, curve: Curves.ease);
  }

  void onNext(Answer answer) {
    animateToPage();
  }
}
