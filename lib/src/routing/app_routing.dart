// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../constants/paths.dart';
import '../widgets/not_found.dart';

final appRoutingProvider = Provider<AppRouting>((ref) {
  return AppRouting();
});

class AppRouting {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>(), tabNavigatorKey = GlobalKey<NavigatorState>();

  GoRouter get router => GoRouter(
        navigatorKey: navigatorKey,
        initialLocation: AppRoute.learn.path,
        errorBuilder: (_, __) {
          return const ErrorScreen(type: ErrorType.notFound);
        },
        routes: [],
      );
}

String path(String path, {Map<String, dynamic>? queryParameters}) {
  return Uri(path: path, queryParameters: queryParameters).toString();
}
