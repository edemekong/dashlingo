import 'package:dashlingo/src/configs/firebase_options.dart';
import 'package:dashlingo/src/theme/theme.dart';
import 'package:dashlingo/src/utils/storage_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum AppFlavor { dev, prod }

Future<void> configureApp(AppFlavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform(flavor));
  } else {
    await Firebase.initializeApp();
  }

  AppTheme.instance.setThemeFromLocalStorage();
  StorageService.instance.initialisePreference();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
}
