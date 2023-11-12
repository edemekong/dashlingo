import 'package:flutter/material.dart';

enum AppMenuType { path, link, tap }

@immutable
class Menu {
  final String title;
  final Widget icon;
  final Widget activeIcon;

  final String link;
  final AppMenuType menuType;
  final String? parent;
  final List<Menu> subRoutes;

  const Menu({
    required this.title,
    this.icon = const SizedBox(),
    this.activeIcon = const SizedBox(),
    this.link = "",
    this.menuType = AppMenuType.path,
    this.parent,
    this.subRoutes = const [],
  });
}
