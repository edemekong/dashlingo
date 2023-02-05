import 'package:dashlingo/services/get_it.dart';
import 'package:dashlingo/services/storage_service.dart';
import 'package:dashlingo/states/app_state.dart';
import 'package:dashlingo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'constants/paths.dart';

class AppRootProviders extends StatelessWidget {
  const AppRootProviders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppState()),
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
        final state = context.watch<AppState>();

        return MaterialApp.router(
          theme: theme,
          title: 'Dashlingo ∙ ${getTitle(state.screenTitle)}',
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

  String getTitle(String? path) {
    if (path == null) {
      return 'Dashlingo';
    }

    if (path.startsWith(profilePath)) {
      path = "Profile";
    } else if (path.startsWith(tutorialsPath)) {
      path = "Tutorials";
    } else if (path.startsWith(learnPath)) {
      path = "Learn";
    } else if (path.startsWith(leaderboard)) {
      path = "Leaderboard";
    } else {
      path = "Not Found";
    }

    return path;
  }
}

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppTheme.instance.setThemeFromLocalStorage();
  StorageService.instance.initialisePreference();

  GetItService.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
}
