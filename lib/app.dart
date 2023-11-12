import 'package:dashlingo/src/routing/app_routing.dart';
import 'package:dashlingo/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashApp extends ConsumerWidget {
  const DashApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appRouting = ref.read(appRoutingProvider);

    return ValueListenableBuilder<ThemeData>(
      valueListenable: AppTheme.instance.themeDataNotifier,
      builder: (context, theme, _) {
        return MaterialApp.router(
          theme: theme,
          title: 'dashlingo ∙ Learn',
          builder: (context, widget) => Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => widget!,
              ),
            ],
          ),
          routerConfig: appRouting.router,
          shortcuts: {
            LogicalKeySet(LogicalKeyboardKey.space): const ActivateIntent(),
          },
        );
      },
    );
  }
}
