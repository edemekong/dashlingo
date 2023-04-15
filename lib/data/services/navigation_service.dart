// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, avoid_web_libraries_in_flutter

import 'package:dashlingo/UI/screens/about/about.dart';
import 'package:dashlingo/UI/screens/leaderboard/leaderboard.dart';
import 'package:dashlingo/UI/screens/learn/learn_view.dart';
import 'package:dashlingo/UI/screens/overview/overview.dart';
import 'package:dashlingo/UI/screens/tutorials/tutorial_view.dart';
import 'package:dashlingo/utils/logs.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import '../../constants/paths.dart';
import '../../UI/screens/lessons/lesson_view.dart';
import '../../UI/screens/not_found.dart';
import '../../UI/screens/tutorial/tutorial_view.dart';

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
    return learnPath;
  }

  GoRouter get router => GoRouter(
        navigatorKey: navigatorKey,
        initialLocation: learnPath,
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
                path: learnPath,
                pageBuilder: (_, state) {
                  return const NoTransitionPage(
                    child: LearnViewWidget(),
                  );
                },
              ),
              GoRoute(
                path: profilePath,
                parentNavigatorKey: tabNavigatorKey,
                pageBuilder: (_, __) {
                  return const NoTransitionPage(
                    child: ProfileViewWidget(),
                  );
                },
              ),
              GoRoute(
                path: tutorialsPath,
                parentNavigatorKey: tabNavigatorKey,
                pageBuilder: (_, __) {
                  return const NoTransitionPage(
                    child: TutorialsView(id: ''),
                  );
                },
              ),
              GoRoute(
                path: tutorialPath,
                parentNavigatorKey: tabNavigatorKey,
                pageBuilder: (_, state) {
                  final id = state.params['id'] ?? '';
                  return NoTransitionPage(
                    child: TutorialView(id: id),
                  );
                },
              ),
              GoRoute(
                path: leaderboard,
                parentNavigatorKey: tabNavigatorKey,
                pageBuilder: (_, state) {
                  return const NoTransitionPage(
                    child: Leaderboard(),
                  );
                },
              ),
              GoRoute(
                path: lessonPath,
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
