import 'package:flutterfairy/constants/paths.dart';
import 'package:flutter/material.dart';

enum AppMenuType { path, link }

@immutable
class Menu {
  final String title;
  final Widget icon;
  final String link;
  final AppMenuType menuType;
  final String? parent;
  final List<Menu> subRoutes;

  const Menu({
    this.parent,
    required this.title,
    this.menuType = AppMenuType.path,
    this.icon = const SizedBox(),
    this.link = homePath,
    this.subRoutes = const [],
  });
}
