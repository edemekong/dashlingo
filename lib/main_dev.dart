import 'dart:async';

import 'package:dashlingo/app.dart';
import 'package:dashlingo/src/configs/app_config.dart';
import 'package:dashlingo/src/utils/logs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runZonedGuarded(() async {
    await configureApp(AppFlavor.dev);

    runApp(const ProviderScope(child: DashApp()));
  }, (error, stack) => dashPrint(error));
}
