import 'package:flutter/material.dart';
import '../../constants/paths.dart';
import '../services/get_it.dart';
import '../services/navigation_service.dart';
import '../../UI/theme/theme.dart';
import '../../UI/components/base_state.dart';

class AppState extends BaseState with WidgetsBindingObserver {
  final navigationService = locate<NavigationService>();
  String screenTitle = AppRoute.learn.path;

  AppState() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        AppTheme.instance.setThemeFromLocalStorage();
        break;

      case AppLifecycleState.paused:
        break;

      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        break;

      default:
    }
  }
}
