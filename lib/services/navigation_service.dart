// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, avoid_web_libraries_in_flutter

import 'package:flutterfairy/screens/about/about.dart';
import 'package:flutterfairy/screens/learn/learn_view.dart';
import 'package:flutterfairy/screens/post/post_view.dart';
import 'package:flutterfairy/screens/posts/posts_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constants/paths.dart';
import '../screens/home/home.dart';
import '../screens/not_found.dart';
import 'get_it.dart';
import '../models/route_data.dart';
import 'dart:html' as html;

class NavigationService {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  ValueNotifier<String> routeNotifier = ValueNotifier<String>(homePath);
  ValueNotifier<bool> showNavigationBar = ValueNotifier<bool>(false);

  List<String> pathToCloseNavigationBar = [];

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
    return homePath;
  }

  Route? onGeneratedRoute(RouteSettings settings) {
    html.window.history.pushState(null, 'flutterfairy', "#${settings.name}");
    final routeData = settings.name?.getRouteData;

    switch (routeData?.route) {
      case aboutPath:
        return navigateToPageRoute(settings, const AboutViewWidget());
      case homePath:
        return navigateToPageRoute(settings, const HomeView());
      case mobileDevPostPath:
        return navigateToPageRoute(
          settings,
          const PostsViewWidget(id: mobileDevPostPath),
        );
      case lifestylePostPath:
        return navigateToPageRoute(
          settings,
          const PostsViewWidget(id: lifestylePostPath),
        );

      case videoTutorialPath:
        return navigateToPageRoute(
          settings,
          const PostsViewWidget(id: videoTutorialPath),
        );

      case dartLearnPath:
        return navigateToPageRoute(
          settings,
          const LearnViewWidget(),
        );

      case flutterLearnPath:
        return navigateToPageRoute(
          settings,
          const LearnViewWidget(),
        );

      case postPath:
        final id = routeData?["id"] ?? "";
        return navigateToPageRoute(settings, PostViewWidget(id: id));
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
        navigationService.routeNotifier.value = settings.name ?? homePath;

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
        navigationService.routeNotifier.value = settings.name ?? homePath;

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

  locate<NavigationService>().pushNamedAndRemoveUntil(path, data: queryParameter);
}
