// ignore_for_file: avoid_renaming_method_parameters

import 'package:dashlingo/screens/overview/overview.dart';
import 'package:dashlingo/services/navigation_service.dart';
import 'package:flutter/material.dart';

class UrlHandlerRouterDelegate extends RouterDelegate<String> {
  @override
  Widget build(BuildContext context) {
    return const OverviewView();
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  Future<bool> popRoute() async {
    return false;
  }

  @override
  void removeListener(VoidCallback listener) {}

  @override
  Future<void> setNewRoutePath(String path) async {
    if (path != "/") {
      pushNamedAndRemoveUntil(path);
    }
  }
}

class UrlHandlerInformationParser extends RouteInformationParser<String> {
  @override
  Future<String> parseRouteInformation(RouteInformation routeInformation) async {
    return "${routeInformation.location}";
  }
}
