import 'package:dashlingo/constants/duration.dart';
import 'package:dashlingo/services/get_it.dart';
import 'package:dashlingo/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../constants/paths.dart';

class HideWidget extends StatelessWidget {
  final Widget child;
  const HideWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final navigationService = locate<NavigationService>();
    return ValueListenableBuilder(
      valueListenable: navigationService.routeNotifier,
      builder: (context, route, child) {
        final isShow = route.startsWith(lessonPath);
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: child,
          ),
          child: isShow ? const SizedBox.shrink() : child!,
        );
      },
      child: child,
    );
  }
}
