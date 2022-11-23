import 'dart:async';

import 'package:flutterfairy/app.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

void main() {
  runZonedGuarded(() async {
    await initializeApp();
    runApp(const AppRootProviders());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}
