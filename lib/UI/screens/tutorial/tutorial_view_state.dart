import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dashlingo/UI/components/base_state.dart';
import 'package:dashlingo/constants/duration.dart';

class TutorialViewState extends BaseState {
  final String id;

  late ScrollController scrollController;

  TutorialViewState(this.id) {
    scrollController = ScrollController();
  }

  void scrollToIndex(Offset offset) {
    scrollController.animateTo(offset.dy - kToolbarHeight, duration: fast, curve: Curves.easeOut);
  }
}
