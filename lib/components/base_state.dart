import 'package:flutter/material.dart';

class BaseState extends ChangeNotifier {
  bool isLoading = false;
  String result = '';

  bool mounted = true;

  setLoading(bool value, {String? message}) {
    isLoading = value;
    result = message ?? '';
    snappNotifyListener();
  }

  snappNotifyListener() {
    if (mounted) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    mounted = false;
    super.dispose();
  }
}
