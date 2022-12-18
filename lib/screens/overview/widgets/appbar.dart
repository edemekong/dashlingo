import 'package:dashlingo/components/texts.dart';
import 'package:dashlingo/screens/overview/widgets/sizedbar.dart';
import 'package:dashlingo/services/get_it.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components/bounce_animation.dart';
import '../../../components/textfield.dart';
import '../../../constants/paths.dart';
import '../../../models/menu.dart';
import '../../../services/navigation_service.dart';
import '../../../theme/spaces.dart';
import '../../../theme/theme.dart';

class DashAppbar extends StatelessWidget {
  final bool isDesktop;
  const DashAppbar({
    Key? key,
    required this.isDesktop,
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
          if (!isDesktop) ...[
            IconButton(
              splashRadius: 20,
              onPressed: () {
                Scaffold.of(navigationService.navigatorKey.currentState!.context).openDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
          ],
          const SizedBox(width: AppSpaces.elementSpacing * 0.5),
          BounceAnimation(
            onTap: () {
              pushNamedAndRemoveUntil(learnPath);
            },
            child: Center(
              child: FairyTexts.headingMedium('dashlingo', context,
                  color: isLight ? Theme.of(context).primaryColor : null),
            ),
          ),
          const SizedBox(width: AppSpaces.cardPadding),
          const Spacer(),
          MenuButtonVertical(
            menu: const Menu(
              title: 'PROFILE',
              icon: Icon(CupertinoIcons.person_circle),
              link: profilePath,
            ),
            disableHighlight: true,
            onChanged: () {},
          ),
          const SizedBox(width: AppSpaces.elementSpacing),
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
