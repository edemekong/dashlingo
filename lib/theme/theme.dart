// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutterfairy/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../constants/local_storage_keys.dart';
import '../services/storage_service.dart';

class AppTheme {
  AppTheme._();

  static AppTheme? _instance;

  static AppTheme get instance {
    _instance ??= AppTheme._();
    return _instance!;
  }

  final storage = StorageService.instance;
  String? theme;

  ValueNotifier<ThemeData> themeDataNotifier = ValueNotifier<ThemeData>(AppThemeData.themeLight);
  bool isLightMode(BuildContext context) => Theme.of(context).brightness == Brightness.light;

  void setThemeFromLocalStorage() async {
    storage.getString(THEME_KEY).then((theme) {
      this.theme = theme ?? SchedulerBinding.instance.window.platformBrightness.name;

      if (theme == "light") {
        themeDataNotifier.value = AppThemeData.themeLight;
      } else if (theme == "dark") {
        themeDataNotifier.value = AppThemeData.themeDark;
      } else {
        // get system theme
        final theme = SchedulerBinding.instance.window.platformBrightness;
        bool isDarkMode = theme == Brightness.dark;
        themeDataNotifier.value = isDarkMode ? AppThemeData.themeDark : AppThemeData.themeLight;
        storage.setString(THEME_KEY, "system");
      }
      themeDataNotifier.notifyListeners();
    });
  }

  void changeTheme(ThemeData data) {
    themeDataNotifier.value = data;
    themeDataNotifier.notifyListeners();
    storage.setString(THEME_KEY, theme ?? data.brightness.name);
  }

  void changeThemeFromName(String theme) {
    this.theme = theme;
    themeDataNotifier.value = (() {
      switch (theme) {
        case "light":
          return AppThemeData.themeLight;
        case "dark":
          return AppThemeData.themeDark;
        default:
          final theme = SchedulerBinding.instance.window.platformBrightness;
          bool isDarkMode = theme == Brightness.dark;
          return isDarkMode ? AppThemeData.themeDark : AppThemeData.themeLight;
      }
    })();
    storage.setString(THEME_KEY, theme);
  }
}
