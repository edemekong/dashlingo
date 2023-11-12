import 'package:flutter/material.dart';

class UIService {
  final ValueNotifier<String?> _loadingText = ValueNotifier<String?>(null);
  final ValueNotifier<OverlayEntry?> _currentOverlay = ValueNotifier<OverlayEntry?>(null);

  bool get isLoading => _loadingText.value != null;
  ValueNotifier<String?> get loadingText => _loadingText;
  void startLoading([String text = "Loading"]) {
    _loadingText.value = text;
  }

  void stopLoading() {
    _loadingText.value = null;
  }

  bool get hasOverlay => _currentOverlay.value != null;
  ValueNotifier<OverlayEntry?> get currentOverlay => _currentOverlay;
  OverlayEntry createOverlay(OverlayEntry entry) {
    _currentOverlay.value = entry;
    return entry;
  }

  void unsetOverlay() {
    _currentOverlay.value?.remove();
    _currentOverlay.value = null;
  }
}
