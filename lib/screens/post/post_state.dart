import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterfairy/components/base_state.dart';
import 'package:flutterfairy/constants/duration.dart';

class PostViewState extends BaseState {
  final String id;

  late ScrollController scrollController;

  PostViewState(this.id) {
    scrollController = ScrollController();
  }

  void scrollToIndex(Offset offset) {
    scrollController.animateTo(offset.dy - kToolbarHeight, duration: fast, curve: Curves.easeOut);
  }
}
