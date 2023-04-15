import 'package:dashlingo/data/services/get_it.dart';
import 'package:dashlingo/data/services/storage_service.dart';
import 'package:dashlingo/data/states/app_state.dart';
import 'package:dashlingo/data/states/auth_state.dart';
import 'package:dashlingo/UI/theme/theme.dart';
import 'package:dashlingo/firebase_options.dart';
import 'package:dashlingo/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'constants/paths.dart';
import 'data/states/user_state.dart';

class AppRootProviders extends StatelessWidget {
  const AppRootProviders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppState(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthState(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (_) => UserState(),
          lazy: false,
        ),
      ],
      child: const DashApp(),
    );
  }
}

class DashApp extends StatelessWidget {
  const DashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeData>(
      valueListenable: AppTheme.instance.themeDataNotifier,
      builder: (context, theme, _) {
        final state = context.read<AppState>();

        return MaterialApp.router(
          theme: theme,
          title: 'dashlingo ∙ ${getTitle(state.screenTitle)}',
          builder: (context, widget) => Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => widget!,
              ),
            ],
          ),
          routerConfig: state.navigationService.router,
          shortcuts: {
            LogicalKeySet(LogicalKeyboardKey.space): const ActivateIntent(),
          },
        );
      },
    );
  }
}

String getTitle(String? path) {
  if (path == null) {
    return 'Learn from dash!';
  }

  if (path.startsWith(AppRoute.profile.path)) {
    path = "Profile";
  } else if (path.startsWith(AppRoute.learn.path)) {
    path = "Learn";
  } else if (path.startsWith(AppRoute.leaderboard.path)) {
    path = "Leaderboard";
  } else {
    path = "Not Found";
  }

  return path;
}

enum AppFlavor { dev, prod }

Future<void> initializeApp(AppFlavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform(flavor));
  } else {
    await Firebase.initializeApp();
  }

  AppTheme.instance.setThemeFromLocalStorage();
  StorageService.instance.initialisePreference();

  GetItService.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
}
