// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, avoid_web_libraries_in_flutter

import 'package:dashlingo/screens/about/about.dart';
import 'package:dashlingo/screens/learn/learn_view.dart';
import 'package:dashlingo/screens/tutorials/tutorial_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constants/paths.dart';
import '../screens/lessons/lesson_view.dart';
import '../screens/not_found.dart';
import '../screens/tutorial/tutorial_view.dart';
import 'get_it.dart';
import '../models/route_data.dart';
import 'dart:html' as html;

class NavigationService {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  ValueNotifier<String> routeNotifier = ValueNotifier<String>(learnPath);
  ValueNotifier<bool> showNavigationBar = ValueNotifier<bool>(false);
  ValueNotifier<int> currentPathIndex = ValueNotifier<int>(0);

  List<String> pathToCloseNavigationBar = [
    lessonPath,
  ];

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  set setNavigationBar(bool value) {
    showNavigationBar.value = value;
    showNavigationBar.notifyListeners();
  }

  late FToast toast;

  NavigationService() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      toast = FToast();
      toast = toast.init(navigatorKey.currentContext!);
    });
  }

  String determineHomePath() {
    return learnPath;
  }

  Route? onGeneratedRoute(RouteSettings settings) {
    html.window.history.pushState(null, 'dashlingo', "#${settings.name}");
    final routeData = settings.name?.getRouteData;

    switch (routeData?.route) {
      case learnPath:
        return navigateToPageRoute(settings, const LearnViewWidget());

      case profilePath:
        return navigateToPageRoute(settings, const ProfileViewWidget());

      case tutorialsPath:
        return navigateToPageRoute(settings, const TutorialsView(id: ''));

      case tutorialPath:
        final id = routeData?["id"] ?? "";
        return navigateToPageRoute(settings, TutorialView(id: id));

      case lessonPath:
        final id = routeData?["id"] ?? "";
        return navigateToPageRoute(settings, const LessonViewWidget());
    }

    return navigateToPageRoute(settings, const ErrorScreen(type: ErrorType.notFound));
  }

  PageRoute navigateToPageRoute(RouteSettings settings, Widget page,
      {bool maintainState = true, bool fullscreenDialog = false}) {
    return PageRouteBuilder(
      pageBuilder: (c, a1, a2) => page,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
      settings: settings,
      transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
      transitionDuration: const Duration(milliseconds: 200),
    );
  }

  void pushNamedAndRemoveUntil<T>(String path, {T? data}) {
    navigatorKey.currentState!.restorablePushNamedAndRemoveUntil(path, (route) => true, arguments: data);
  }
}

class RouteObservers extends RouteObserver<PageRoute<dynamic>> {
  RouteObservers();

  final navigationService = locate<NavigationService>();

  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    if (previousRoute is PageRoute && route is PageRoute) {
      final settings = previousRoute.settings;
      if (settings.name != '/') {
        // navigationService.routeNotifier.value = settings.name ?? homePath;

        final containPreviousRoutePath =
            navigationService.pathToCloseNavigationBar.contains(previousRoute.settings.name);

        if (containPreviousRoutePath) {
          navigationService.setNavigationBar = false;
        }

        if (!containPreviousRoutePath) {
          navigationService.setNavigationBar = true;
        }
      }
    }
    super.didPop(route!, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    if (previousRoute is PageRoute && route is PageRoute) {
      final settings = route.settings;

      if (settings.name != '/') {
        // navigationService.routeNotifier.value = settings.name ?? homePath;

        final paths = navigationService.pathToCloseNavigationBar;
        final containRoutePath = paths.contains(route.settings.name);

        if (containRoutePath) {
          navigationService.setNavigationBar = false;
        } else {
          navigationService.setNavigationBar = true;
        }
      }
    }
    super.didPush(route, previousRoute);
  }
}

Future<void> pushNamedAndRemoveUntil<T>(String path, {Map<String, dynamic>? queryParameter}) async {
  if (queryParameter != null) {
    path = Uri(path: path, queryParameters: queryParameter).toString();
  }

  final navigationService = locate<NavigationService>();
  navigationService.routeNotifier.value = path;

  int index = tabPaths.indexWhere((element) => (element == path || path.startsWith(element)));
  if (index != -1) {
    navigationService.currentPathIndex.value = index;
  }
  navigationService.pushNamedAndRemoveUntil(path, data: queryParameter);
}
