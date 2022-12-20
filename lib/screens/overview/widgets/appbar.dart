import 'package:dashlingo/components/display_image.dart';
import 'package:dashlingo/components/texts.dart';
import 'package:dashlingo/constants/images_path.dart';
import 'package:dashlingo/screens/overview/widgets/sizedbar.dart';
import 'package:dashlingo/services/get_it.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../components/bounce_animation.dart';
import '../../../constants/paths.dart';
import '../../../models/menu.dart';
import '../../../services/navigation_service.dart';
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
    final navigationService = locate<NavigationService>();

    return Container(
      width: MediaQuery.of(context).size.width,
      height: kToolbarHeight * 1.2,
      color: Theme.of(context).backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: AppSpaces.elementSpacing),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // if (!isDesktop) ...[
          //   IconButton(
          //     splashRadius: 20,
          //     onPressed: () {
          //       Scaffold.of(navigationService.navigatorKey.currentState!.context).openDrawer();
          //     },
          //     icon: const Icon(Icons.menu),
          //   ),
          // ],
          // const SizedBox(width: AppSpaces.elementSpacing * 0.5),
          BounceAnimation(
            onTap: () {
              pushNamedAndRemoveUntil(learnPath);
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
                  DashTexts.headingMedium('dashlingo', context, color: isLight ? Theme.of(context).primaryColor : null),
                ],
              ),
            ),
          ),
          const SizedBox(width: AppSpaces.cardPadding),
          const Spacer(),
          if (info.isDesktop || info.isTablet) ...[
            MenuButtonVertical(
              iconOnly: true,
              menu: const Menu(
                title: 'PROFILE',
                icon: Icon(CupertinoIcons.person_circle),
                link: profilePath,
              ),
              disableHighlight: true,
              onChanged: () {},
            ),
          ],

          IconButton(
            splashRadius: 20,
            onPressed: () {
              final String theme =
                  Theme.of(context).brightness == Brightness.light ? Brightness.dark.name : Brightness.light.name;
              AppTheme.instance.changeThemeFromName(theme);
            },
            icon: Icon(isLight ? Icons.nightlight_round_sharp : Icons.sunny),
          ),
        ],
      ),
    );
  }
}
