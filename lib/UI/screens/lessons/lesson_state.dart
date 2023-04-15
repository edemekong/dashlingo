import 'package:flutter/material.dart';
import 'package:dashlingo/UI/components/base_state.dart';
import 'package:dashlingo/constants/duration.dart';
import '../../../constants/mocks/learns.dart';
import '../../../data/models/learn/learn.dart';

class LessonState extends BaseState {
  late PageController pageController;

  int currentPageIndex = 0;
  List<Learn> playAndLearn = [];

  Map<String, dynamic> answers = {};

  LessonState() {
    pageController = PageController();
    playAndLearn = learns.cast<Learn>();
  }

  void onPageChanged(int index) {
    currentPageIndex = index;
    notifyListeners();
  }

  void animateToPage() {
    if ((currentPageIndex + 1) >= learns.length) return;
    currentPageIndex++;
    notifyListeners();
    pageController.animateToPage(currentPageIndex, duration: fast, curve: Curves.ease);
  }

  void onNext(Answer answer) {
    animateToPage();
  }
}
