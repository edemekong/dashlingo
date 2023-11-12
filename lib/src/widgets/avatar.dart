import 'package:dashlingo/src/theme/spaces.dart';
import 'package:flutter/material.dart';

import '../constants/images_path.dart';
import '../theme/theme.dart';
import 'display_image.dart';

class ProfileAvater extends StatelessWidget {
  final String? url;
  final double size;
  final bool local;
  final Color? color;

  const ProfileAvater({
    Key? key,
    required this.url,
    this.size = 100,
    this.local = true,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLight = AppTheme.instance.isLightMode(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: AppSpaces.defaultCircularRadius,
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: ClipRRect(
        borderRadius: AppSpaces.defaultCircularRadius,
        child: DisplayImage(
          fit: BoxFit.cover,
          width: size,
          height: size,
          url: url,
          icon: Image.asset(
            isLight ? ImagePaths.dashLight : ImagePaths.dash,
            width: size,
            height: size,
            scale: size > 80 ? 0.1 : 1,
          ),
        ),
      ),
    );
  }
}
