import 'package:flutterfairy/services/get_it.dart';
import 'package:flutterfairy/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../../components/bounce_animation.dart';
import '../../../components/display_image.dart';
import '../../../constants/icon_path.dart';
import '../../../constants/paths.dart';
import '../../../services/navigation_service.dart';
import '../../../theme/spaces.dart';
import '../../../theme/theme.dart';

class EdAppbar extends StatelessWidget {
  final bool showMenu;
  const EdAppbar({
    Key? key,
    required this.showMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final navigationService = locate<NavigationService>();

    return Container(
      width: MediaQuery.of(context).size.width,
      height: kToolbarHeight * 1.2,
      color: showMenu ? (isLight ? AppColors.lightGrey : AppColors.darkBlue) : Theme.of(context).backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: AppSpaces.elementSpacing),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (showMenu) ...[
            IconButton(
              splashRadius: 20,
              onPressed: () {
                Scaffold.of(navigationService.navigatorKey.currentState!.context).openDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
            const SizedBox(width: AppSpaces.elementSpacing),
            BounceAnimation(
              onTap: () {
                pushNamedAndRemoveUntil(homePath);
              },
              child: Center(
                child: DisplayImage(
                  url: IconPaths.logo,
                  backgroundColor: Theme.of(context).primaryColor,
                  width: 120,
                ),
              ),
            ),
          ],
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
        ],
      ),
    );
  }
}
