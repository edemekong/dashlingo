import 'package:flutterfairy/utils/logs.dart';
import 'package:flutter/material.dart';

import '../constants/paths.dart';
import '../services/get_it.dart';
import '../services/navigation_service.dart';
import '../theme/theme.dart';
import '../components/base_state.dart';

class AppState extends BaseState with WidgetsBindingObserver {
  final navigationService = locate<NavigationService>();
  String screenTitle = homePath;

  AppState() {
    WidgetsBinding.instance.addObserver(this);
    navigationService.routeNotifier.addListener(_listenToTitle);
  }

  @override
  void dispose() {
    navigationService.routeNotifier.removeListener(_listenToTitle);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    edPrint(state);

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

  void _listenToTitle() {
    screenTitle = navigationService.routeNotifier.value;
    notifyListeners();
  }
}
