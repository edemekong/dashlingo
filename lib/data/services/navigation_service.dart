// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, avoid_web_libraries_in_flutter

import 'package:dashlingo/UI/screens/about/about.dart';
import 'package:dashlingo/UI/screens/leaderboard/leaderboard.dart';
import 'package:dashlingo/UI/screens/learn/learn_view.dart';
import 'package:dashlingo/UI/screens/overview/overview.dart';
import 'package:dashlingo/utils/logs.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import '../../constants/paths.dart';
import '../../UI/screens/lessons/lesson_view.dart';
import '../../UI/screens/not_found.dart';

class NavigationService {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> tabNavigatorKey = GlobalKey<NavigatorState>();

  ValueNotifier<int> currentPathIndex = ValueNotifier<int>(0);

  late FToast toast;

  NavigationService() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      toast = FToast();
      toast = toast.init(navigatorKey.currentContext!);
    });
  }

  String determineHomePath() {
    return AppRoute.learn.path;
  }

  GoRouter get router => GoRouter(
        navigatorKey: navigatorKey,
        initialLocation: AppRoute.learn.path,
        errorBuilder: (_, __) {
          return const ErrorScreen(type: ErrorType.notFound);
        },
        routes: [
          ShellRoute(
            navigatorKey: tabNavigatorKey,
            pageBuilder: (context, state, child) {
              return NoTransitionPage(
                child: OverviewView(body: child),
              );
            },
            routes: [
              GoRoute(
                path: AppRoute.learn.path,
                name: AppRoute.learn.name,
                pageBuilder: (_, state) {
                  return const NoTransitionPage(
                    child: LearnViewWidget(),
                  );
                },
              ),
              GoRoute(
                path: AppRoute.profile.path,
                name: AppRoute.profile.name,
                parentNavigatorKey: tabNavigatorKey,
                pageBuilder: (_, __) {
                  return const NoTransitionPage(
                    child: ProfileViewWidget(),
                  );
                },
              ),
              GoRoute(
                path: AppRoute.leaderboard.path,
                name: AppRoute.leaderboard.name,
                parentNavigatorKey: tabNavigatorKey,
                pageBuilder: (_, state) {
                  return const NoTransitionPage(
                    child: Leaderboard(),
                  );
                },
              ),
              GoRoute(
                path: AppRoute.lesson.path,
                name: AppRoute.lesson.name,
                parentNavigatorKey: tabNavigatorKey,
                pageBuilder: (_, state) {
                  dashPrint(state.queryParams);
                  return const NoTransitionPage(
                    child: LessonViewWidget(),
                  );
                },
              ),
            ],
          ),
        ],
      );
}

String path(String path, {Map<String, dynamic>? queryParameters}) {
  return Uri(path: path, queryParameters: queryParameters).toString();
}
