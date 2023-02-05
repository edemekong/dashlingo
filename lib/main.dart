import 'dart:async';

import 'package:dashlingo/app.dart';
import 'package:flutter/material.dart';
import 'package:dashlingo/utils/logs.dart';

void main() {
  runZonedGuarded(() async {
    await initializeApp();
    runApp(const AppRootProviders());
  }, (error, stack) => edPrint(error));
}

// FirebaseCrashlytics.instance.recordError(error, stack)