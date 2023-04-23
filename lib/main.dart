import 'dart:async';

import 'package:dashlingo/app.dart';
import 'package:dashlingo/utils/logs.dart';
import 'package:flutter/material.dart';

void main(List _, [AppFlavor flavor = AppFlavor.prod]) {
  runZonedGuarded(() async {
    await initializeApp(flavor);
    runApp(const AppRootProviders());
  }, (error, stack) => dashPrint(error));
}
