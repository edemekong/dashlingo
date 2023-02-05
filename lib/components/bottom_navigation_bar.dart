import 'package:dashlingo/models/menu.dart';
import 'package:dashlingo/screens/overview/widgets/sizedbar.dart';
import 'package:dashlingo/theme/spaces.dart';
import 'package:dashlingo/utils/logs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/paths.dart';
import '../services/get_it.dart';
import '../services/navigation_service.dart';
import 'hide_widget.dart';

class AppBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  const AppBottomNavigationBar({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  List<Menu> menus = [];

  @override
  void initState() {
    super.initState();

    menus.addAll(tabs);
  }

  @override
  Widget build(BuildContext context) {
    final navigationService = locate<NavigationService>();

    return HideWidget(
        child: ValueListenableBuilder<int>(
      valueListenable: navigationService.currentPathIndex,
      builder: (context, _, __) {
        final value = GoRouter.of(context).location;

        final int index = tabPaths.indexWhere((element) => element.startsWith(value));

        final int currentIndex = index != -1 ? index : 0;

        return Padding(
          padding: const EdgeInsets.only(top: AppSpaces.elementSpacing * 0.5),
          child: ClipRRect(
            child: BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: true,
              iconSize: 38,
              selectedIconTheme: Theme.of(context).iconTheme.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
              unselectedIconTheme: Theme.of(context).iconTheme,
              currentIndex: currentIndex,
              onTap: (index) {
                context.go(tabPaths[index]);
              },
              items: List.generate(
                menus.length,
                (index) {
                  Menu menu = menus[index];
                  return BottomNavigationBarItem(
                    label: '',
                    tooltip: menu.title,
                    activeIcon: IconTheme(
                      data: Theme.of(context).iconTheme.copyWith(
                            size: 40,
                            color: Theme.of(context).primaryColor,
                          ),
                      child: menu.activeIcon,
                    ),
                    icon: IconTheme(
                      data: Theme.of(context).iconTheme.copyWith(
                            size: 40,
                          ),
                      child: menu.icon,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    ));
  }
}
