import 'package:dashlingo/utils/logs.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import 'get_it.dart';

class CrashlyticsService {
  static CrashlyticsService get instance => locate<CrashlyticsService>();

  final FirebaseCrashlytics _firebaseCrashlytics = FirebaseCrashlytics.instance;

  Future<void> reportCrash(dynamic exception, String identifier,
      {StackTrace? stack, String? errorDescription, bool fatal = true}) async {
    try {
      final details = FlutterErrorDetails(
        exception: exception,
        stack: stack,
        context: ErrorDescription(errorDescription ?? 'An error type ${stack.runtimeType}'),
      );

      _firebaseCrashlytics.setUserIdentifier(identifier);
      _firebaseCrashlytics.recordFlutterError(details, fatal: fatal);
    } catch (e) {
      dashPrint(e);
    }
  }

  Future<void> logError(dynamic exception) async {
    try {
      _firebaseCrashlytics.log(exception);
    } catch (e) {
      dashPrint(e);
    }
  }
}
