import 'package:flutterfairy/components/bounce_animation.dart';
import 'package:flutterfairy/components/display_image.dart';
import 'package:flutterfairy/components/textfield.dart';
import 'package:flutterfairy/components/texts.dart';
import 'package:flutterfairy/constants/icon_path.dart';
import 'package:flutterfairy/constants/paths.dart';
import 'package:flutter/material.dart';
import '../../../models/menu.dart';
import '../../../services/get_it.dart';
import '../../../services/navigation_service.dart';
import '../../../theme/colors.dart';
import '../../../theme/spaces.dart';

class EdSizedbar extends StatelessWidget {
  final bool drawer;
  const EdSizedbar({Key? key, required, required this.drawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      color: isLight ? AppColors.lightGrey : AppColors.darkBlue,
      height: MediaQuery.of(context).size.height,
      width: AppSpaces.webWidth * 0.25,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpaces.cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BounceAnimation(
                    onTap: () {
                      pushNamedAndRemoveUntil(homePath);
                    },
                    child: Column(
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: AppSpaces.defaultBorderRadius,
                            child: DisplayImage(
                              url: IconPaths.logo,
                              width: 150,
                              backgroundColor: isLight ? AppColors.black : AppColors.white,
                              local: true,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpaces.elementSpacing),
                      ],
                    ),
                  ),
                  const EdTextfield(
                    hintText: 'Search anything',
                    showClear: true,
                    maxLines: 1,
                    padding: EdgeInsets.zero,
                    prefix: Icon(Icons.search),
                  ),
                  const SizedBox(height: AppSpaces.cardPadding),
                  ...List.generate(
                    tabs.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpaces.elementSpacing),
                      child: MenuButtonVertical(
                        menu: tabs[index],
                        onChanged: () {
                          if (drawer) {
                            Scaffold.of(context).closeDrawer();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuButtonVertical extends StatefulWidget {
  final Menu menu;
  final void Function() onChanged;
  const MenuButtonVertical({Key? key, required this.menu, required this.onChanged}) : super(key: key);

  @override
  State<MenuButtonVertical> createState() => _MenuButtonVerticalState();
}

class _MenuButtonVerticalState extends State<MenuButtonVertical> {
  bool _isHovered = false;

  void _onHover(bool value) {
    setState(() {
      _isHovered = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final navigationService = locate<NavigationService>();

    return ValueListenableBuilder<String>(
      valueListenable: navigationService.routeNotifier,
      builder: (context, value, _) {
        final isTapped = widget.menu.link == value;

        if (widget.menu.subRoutes.isNotEmpty) {
          return ListTileTheme(
            dense: true,
            minVerticalPadding: 0,
            horizontalTitleGap: AppSpaces.elementSpacing,
            minLeadingWidth: 10,
            child: ExpansionTile(
              iconColor: Theme.of(context).iconTheme.color,
              collapsedIconColor: Theme.of(context).iconTheme.color,
              onExpansionChanged: (_) {},
              tilePadding: const EdgeInsets.only(
                left: AppSpaces.elementSpacing * 0.5,
              ),
              childrenPadding: const EdgeInsets.only(left: AppSpaces.cardPadding),
              title: EdTexts.subHeading(
                widget.menu.title,
                context,
                color: Theme.of(context).iconTheme.color?.withOpacity(.8),
              ),
              children: List.generate(
                widget.menu.subRoutes.length,
                (index) {
                  final subMenu = widget.menu.subRoutes[index];
                  return MenuButtonVertical(
                    menu: subMenu,
                    onChanged: () {
                      widget.onChanged();
                    },
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
            pushNamedAndRemoveUntil(widget.menu.link);
          },
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: AppSpaces.elementSpacing * 0.5),
            child: Row(
              children: [
                if (isTapped) ...[
                  Container(
                    width: 5,
                    height: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
                const SizedBox(width: AppSpaces.elementSpacing * 0.5),
                EdTexts.subHeading(
                  widget.menu.title,
                  context,
                  fontWeight: isTapped || _isHovered ? FontWeight.w500 : FontWeight.w200,
                  color: isTapped
                      ? Theme.of(context).primaryColor
                      : (_isHovered
                          ? Theme.of(context).iconTheme.color
                          : Theme.of(context).iconTheme.color?.withOpacity(.8)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MenuButtonHorizontal extends StatefulWidget {
  final Menu menu;
  final void Function() onChanged;
  const MenuButtonHorizontal({
    Key? key,
    required this.menu,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<MenuButtonHorizontal> createState() => _MenuButtonLinkState();
}

class _MenuButtonLinkState extends State<MenuButtonHorizontal> {
  bool _isHovered = false;

  bool show = false;

  void _onHover(bool value) {
    setState(() {
      _isHovered = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final navigationService = locate<NavigationService>();

    return ValueListenableBuilder<String>(
      valueListenable: navigationService.routeNotifier,
      builder: (context, value, _) {
        final isTapped = widget.menu.link == value;

        return BounceAnimation(
          onHover: (_) => _onHover(true),
          onExit: (_) => _onHover(false),
          onTap: () {
            widget.onChanged();
            pushNamedAndRemoveUntil(widget.menu.link);
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: AppSpaces.elementSpacing, top: AppSpaces.elementSpacing),
            padding: const EdgeInsets.symmetric(vertical: AppSpaces.elementSpacing * 0.5),
            child: EdTexts.subHeading(
              widget.menu.title,
              context,
              fontWeight: isTapped || _isHovered ? FontWeight.w500 : FontWeight.w200,
              color: isTapped ? Theme.of(context).primaryColor : null,
            ),
          ),
        );
      },
    );
  }
}

const List<Menu> tabs = [
  Menu(
    title: 'Home',
    link: homePath,
  ),
  Menu(
    title: 'Latest Posts',
    link: lastPostPath,
    subRoutes: [
      Menu(
        title: 'Mobile Development',
        link: mobileDevPostPath,
        parent: lastPostPath,
      ),
      Menu(
        title: 'Lifestyle',
        parent: lastPostPath,
        link: lifestylePostPath,
      ),
    ],
  ),
  Menu(
    title: 'Video Tutorials',
    link: videoTutorialPath,
  ),
  Menu(
    title: 'Practice',
    link: practicePath,
    parent: practicePath,
    subRoutes: [
      Menu(
        title: 'Dart',
        link: dartPracticePath,
        parent: practicePath,
      ),
      Menu(
        title: 'Flutter',
        link: flutterPracticePath,
        parent: practicePath,
      ),
    ],
  ),
  Menu(
    title: 'About',
    link: aboutPath,
  ),
];
