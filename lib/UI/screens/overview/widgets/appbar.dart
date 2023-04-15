import 'package:dashlingo/app.dart';
import 'package:dashlingo/UI/components/display_image.dart';
import 'package:dashlingo/UI/components/texts.dart';
import 'package:dashlingo/constants/images_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../components/bounce_animation.dart';
import '../../../../constants/paths.dart';
import '../../../theme/spaces.dart';
import '../../../theme/theme.dart';

class DashAppbar extends StatelessWidget {
  final SizingInformation info;

  const DashAppbar({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    final path = GoRouter.of(context).location;

    final isHome = [AppRoute.learn.path].contains(path);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: kToolbarHeight * 1.2,
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.symmetric(horizontal: AppSpaces.elementSpacing),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if ((info.isDesktop || info.isTablet) || isHome) ...[
              BounceAnimation(
                onTap: () {
                  context.go(AppRoute.learn.path);
                },
                child: Center(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: AppSpaces.elementSpacing * 0.8),
                        child: DisplayImage(
                          url: isLight ? ImagePaths.dashLight : ImagePaths.dash,
                        ),
                      ),
                      const SizedBox(width: AppSpaces.elementSpacing * 0.8),
                      DashTexts.headingMedium('dashlingo', context,
                          color: isLight ? Theme.of(context).primaryColor : null),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSpaces.cardPadding),
              const Spacer(),
              IconButton(
                splashRadius: 20,
                onPressed: () {
                  final String theme =
                      Theme.of(context).brightness == Brightness.light ? Brightness.dark.name : Brightness.light.name;
                  AppTheme.instance.changeThemeFromName(theme);
                },
                icon: Icon(isLight ? Icons.nightlight_round_sharp : Icons.sunny),
              ),
            ] else ...[
              DashTexts.headingMedium(
                getTitle(path),
                context,
                color: isLight ? Theme.of(context).primaryColor : null,
              ),
              const Spacer(),
              IconButton(
                splashRadius: 20,
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ]),
    );
  }
}
