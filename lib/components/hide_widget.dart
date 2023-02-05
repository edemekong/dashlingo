import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/paths.dart';

class HideWidget extends StatelessWidget {
  final Alignment alignment;

  final Widget child;
  const HideWidget({super.key, required this.child, this.alignment = Alignment.topCenter});

  @override
  Widget build(BuildContext context) {
    final isShow = GoRouter.of(context).location.startsWith(lessonPath);
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
