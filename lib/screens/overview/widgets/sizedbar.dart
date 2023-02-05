import 'dart:async';

import 'package:dashlingo/components/bounce_animation.dart';
import 'package:dashlingo/components/texts.dart';
import 'package:dashlingo/constants/paths.dart';
import 'package:dashlingo/utils/logs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dashlingo/services/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../models/menu.dart';
import '../../../services/navigation_service.dart';
import '../../../theme/spaces.dart';

class DashSizedbar extends StatelessWidget {
  final SizingInformation info;
  const DashSizedbar({
    Key? key,
    required,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: AppSpaces.elementSpacing * 0.5,
                horizontal: AppSpaces.elementSpacing,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpaces.cardPadding),
                  ...List.generate(
                    tabs.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpaces.elementSpacing),
                        child: MenuButtonVertical(
                          menu: tabs[index],
                          onChanged: () {},
                          iconOnly: info.isTablet,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpaces.elementSpacing,
              bottom: AppSpaces.elementSpacing,
            ),
            child: MenuButtonVertical(
              menu: const Menu(
                title: 'LOGOUT',
                icon: Icon(Icons.logout),
                link: '/logout',
              ),
              onChanged: () {},
              iconOnly: info.isTablet,
            ),
          ),
        ],
      ),
    );
  }
}

class MenuButtonVertical extends StatefulWidget {
  final Menu menu;
  final bool disableHighlight;
  final void Function() onChanged;
  final bool iconOnly;
  const MenuButtonVertical({
    Key? key,
    required this.menu,
    required this.onChanged,
    this.disableHighlight = false,
    this.iconOnly = false,
  }) : super(key: key);

  @override
  State<MenuButtonVertical> createState() => _MenuButtonVerticalState();
}

class _MenuButtonVerticalState extends State<MenuButtonVertical> {
  bool _isHovered = false;
  Timer? _timer;

  void _onHover(bool value) {
    _timer?.cancel();
    _timer = null;
    _timer = Timer(const Duration(milliseconds: 150), () {
      setState(() {
        _isHovered = value;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navigationService = locate<NavigationService>();
    final Color buttonColor = Theme.of(context).primaryColor;

    final value = GoRouter.of(context).location;

    final isTapped =
        widget.disableHighlight == false && (widget.menu.link == value || value.startsWith(widget.menu.link));

    if (widget.menu.subRoutes.isNotEmpty) {
      return ListTileTheme(
        dense: true,
        minVerticalPadding: 0,
        horizontalTitleGap: AppSpaces.elementSpacing,
        minLeadingWidth: 10,
        child: ExpansionTile(
          leading: IconTheme(
              data: Theme.of(context).iconTheme.copyWith(
                    size: 30,
                    color: isTapped
                        ? buttonColor
                        : (_isHovered
                            ? Theme.of(context).iconTheme.color
                            : Theme.of(context).iconTheme.color?.withOpacity(.8)),
                  ),
              child: widget.menu.icon),
          iconColor: Theme.of(context).iconTheme.color,
          collapsedIconColor: Theme.of(context).iconTheme.color,
          onExpansionChanged: (_) {},
          tilePadding: const EdgeInsets.only(
            left: AppSpaces.elementSpacing * 0.25,
          ),
          childrenPadding: const EdgeInsets.only(left: AppSpaces.cardPadding),
          title: DashTexts.subHeading(
            widget.menu.title,
            context,
            color: Theme.of(context).iconTheme.color?.withOpacity(.8),
          ),
          children: List.generate(
            widget.menu.subRoutes.length,
            (index) {
              final subMenu = widget.menu.subRoutes[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpaces.elementSpacing * 0.5),
                child: MenuButtonVertical(
                  menu: subMenu,
                  onChanged: () {
                    widget.onChanged();
                  },
                  iconOnly: true,
                ),
              );
            },
          ),
        ),
      );
    }
    return BounceAnimation(
      onHover: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      onTap: () {
        widget.onChanged();
        // pushNamedAndRemoveUntil(widget.menu.link);
        context.go(widget.menu.link);
      },
      child: Container(
        constraints: BoxConstraints(
          minWidth: widget.iconOnly ? 35 : 200,
        ),
        padding: const EdgeInsets.symmetric(vertical: AppSpaces.elementSpacing * 0.5),
        decoration: BoxDecoration(
          color: isTapped ? buttonColor.withOpacity(.1) : null,
          borderRadius: BorderRadius.circular(8),
          border: isTapped
              ? Border.all(
                  width: 1.5,
                  color: buttonColor,
                )
              : null,
        ),
        child: Row(
          children: [
            const SizedBox(width: AppSpaces.elementSpacing * 0.5),
            IconTheme(
                data: Theme.of(context).iconTheme.copyWith(
                      size: 30,
                      color: isTapped
                          ? buttonColor
                          : (_isHovered
                              ? Theme.of(context).iconTheme.color
                              : Theme.of(context).iconTheme.color?.withOpacity(.8)),
                    ),
                child: isTapped ? widget.menu.activeIcon : widget.menu.icon),
            if (!widget.iconOnly) ...[
              const SizedBox(width: AppSpaces.elementSpacing * 0.5),
              DashTexts.subHeadingSmall(
                widget.menu.title,
                context,
                fontWeight: isTapped || _isHovered ? FontWeight.w700 : FontWeight.w600,
                color: isTapped
                    ? buttonColor
                    : (_isHovered
                        ? Theme.of(context).iconTheme.color
                        : Theme.of(context).iconTheme.color?.withOpacity(.8)),
              ),
            ],
            const SizedBox(width: AppSpaces.elementSpacing * 0.5),
          ],
        ),
      ),
    );
  }
}

const List<Menu> tabs = [
  Menu(
    title: 'LEARN',
    link: learnPath,
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home),
  ),
  Menu(
    title: 'TUTORIALS',
    icon: Icon(Icons.article_outlined),
    activeIcon: Icon(Icons.article),
    link: tutorialsPath,
  ),
  Menu(
    title: 'LEADERBOARD',
    link: leaderboard,
    activeIcon: Icon(Icons.emoji_events),
    icon: Icon(Icons.emoji_events_outlined),
  ),
  Menu(
    title: 'PROFILE',
    icon: Icon(CupertinoIcons.person_circle),
    activeIcon: Icon(CupertinoIcons.person_circle_fill),
    link: profilePath,
  )
];
