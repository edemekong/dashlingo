import 'package:flutterfairy/route_delegates.dart';
import 'package:flutterfairy/services/get_it.dart';
import 'package:flutterfairy/services/storage_service.dart';
import 'package:flutterfairy/states/app_state.dart';
import 'package:flutterfairy/theme/theme.dart';
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
      child: const EdpiiiApp(),
    );
  }
}

class EdpiiiApp extends StatelessWidget {
  const EdpiiiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeData>(
      valueListenable: AppTheme.instance.themeDataNotifier,
      builder: (context, theme, _) {
        final state = context.watch<AppState>();

        return MaterialApp.router(
          theme: theme,
          title: 'flutterfairy ∙ ${getTitle(state.screenTitle)}',
          builder: (context, widget) => Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => widget!,
              ),
            ],
          ),
          shortcuts: {
            LogicalKeySet(LogicalKeyboardKey.space): const ActivateIntent(),
          },
          routerDelegate: UrlHandlerRouterDelegate(),
          routeInformationParser: UrlHandlerInformationParser(),
        );
      },
    );
  }

  String getTitle(String? path) {
    if (path == null) {
      return 'Edpiii';
    }

    if (path.startsWith(aboutPath)) {
      path = "About";
    } else if (path.startsWith(contactPath)) {
      path = "Contact";
    } else if (path.startsWith(lastPostPath)) {
      path = "Latest Posts";
    } else if (path.startsWith(videoTutorialPath)) {
      path = "Video Tutorials";
    } else if (path.startsWith(homePath)) {
      path = "Home";
    } else if (path.startsWith(postPath)) {
      path = "Post";
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
