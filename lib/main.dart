import 'dart:async';

import 'package:dashlingo/app.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

void main(List _, [AppFlavor flavor = AppFlavor.prod]) {
  runZonedGuarded(() async {
    await initializeApp(flavor);
    runApp(const AppRootProviders());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}
