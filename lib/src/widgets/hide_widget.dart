import 'package:dashlingo/src/constants/paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HideWidget extends StatelessWidget {
  final Alignment alignment;

  final Widget child;
  const HideWidget({super.key, required this.child, this.alignment = Alignment.topCenter});

  @override
  Widget build(BuildContext context) {
    final isShow = GoRouterState.of(context).name!.startsWith(AppRoute.lesson.path);

    return ClipRRect(
      child: AnimatedAlign(
        curve: Curves.easeInOut,
        alignment: alignment,
        heightFactor: [Alignment.topCenter, Alignment.bottomCenter].contains(alignment)
            ? !isShow
                ? 1.0
                : 0.0
            : null,
        widthFactor: [Alignment.centerRight, Alignment.centerLeft].contains(alignment)
            ? !isShow
                ? 1.0
                : 0.0
            : null,
        duration: const Duration(milliseconds: 150),
        child: child,
      ),
    );
  }
}
