import 'package:flutter/material.dart';
import 'package:flutterfairy/components/base_state.dart';
import 'package:flutterfairy/constants/duration.dart';
import 'package:flutterfairy/constants/mock.dart';
import 'package:flutterfairy/models/quiz.dart';
import 'package:flutterfairy/utils/logs.dart';

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
    edPrint(answer.id);
    animateToPage();
  }
}
