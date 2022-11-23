import 'package:flutterfairy/theme/spaces.dart';
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

    return ClipRRect(
      borderRadius: AppSpaces.defaultCircularRadius,
      child: DisplayImage(
        fit: BoxFit.cover,
        local: local,
        width: size,
        height: size,
        url: url,
        icon: Image.asset(
          isLight ? ImagePaths.profileLight : ImagePaths.profileDark,
          width: size,
          height: size,
          scale: size > 80 ? 0.1 : 1,
        ),
      ),
    );
  }
}
