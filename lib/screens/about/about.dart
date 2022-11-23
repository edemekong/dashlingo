import 'package:flutterfairy/components/avatar.dart';
import 'package:flutterfairy/components/bounce_animation.dart';
import 'package:flutterfairy/components/texts.dart';
import 'package:flutterfairy/constants/font_family.dart';
import 'package:flutterfairy/constants/images_path.dart';
import 'package:flutterfairy/theme/colors.dart';
import 'package:flutterfairy/theme/spaces.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/scaffold.dart';
import '../../constants/icon_path.dart';
import '../../models/menu.dart';

List<Menu> links = [
  Menu(
    title: 'Github',
    icon: Image.asset(
      IconPaths.github,
      width: 50,
      color: AppColors.white,
    ),
    menuType: AppMenuType.link,
    link: 'github.com/flutterfairy',
  ),
  Menu(
    title: 'Facebook',
    icon: Image.asset(IconPaths.facebook),
    menuType: AppMenuType.link,
    link: 'facebook.com/flutterfairy',
  ),
  Menu(
    title: 'Instagram',
    icon: Image.asset(IconPaths.instagram),
    menuType: AppMenuType.link,
    link: 'instagram.com/flutterfairy',
  ),
  Menu(
    title: 'Linkedin',
    icon: Image.asset(IconPaths.linkedIn),
    menuType: AppMenuType.link,
    link: 'linkedin.com/in/flutterfairy/',
  ),
  Menu(
    title: 'Youtube',
    icon: Image.asset(IconPaths.youtube),
    menuType: AppMenuType.link,
    link: 'youtube.com/@flutterfairy',
  ),
];

class AboutViewWidget extends StatelessWidget {
  const AboutViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpaces.cardPadding * 2),
          child: Column(
            children: [
              const SizedBox(height: AppSpaces.cardPadding * 2),
              const ProfileAvater(
                url: ImagePaths.flutterfairy,
                size: 250,
                local: true,
              ),
              const SizedBox(height: AppSpaces.cardPadding),
              EdTexts.headingMedium(
                "Paul Jeremiah",
                context,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w800,
              ),
              const SizedBox(height: AppSpaces.elementSpacing),
              EdTexts.subHeading(
                'CODE | CODE REVIEW | CLEAN CODE | LIFESTYLE',
                context,
                fontFamily: COURIER_NEW,
                fontWeight: FontWeight.w700,
                center: true,
              ),
              const SizedBox(height: AppSpaces.cardPadding * 2),
              FittedBox(
                child: SocialLinks(
                  socialLinks: links,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialLinks extends StatelessWidget {
  final List<Menu> socialLinks;
  const SocialLinks({
    Key? key,
    required,
    required this.socialLinks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        socialLinks.length,
        (index) => BounceAnimation(
          onTap: () async {
            if (socialLinks[index].menuType == AppMenuType.link) {
              final parse = Uri.parse('https://${socialLinks[index].link}');
              bool canLaunch = await canLaunchUrl(parse);
              if (canLaunch) {
                await launchUrl(parse);
              }
            }
          },
          child: Container(
            height: 45,
            margin: const EdgeInsets.all(AppSpaces.elementSpacing * 0.5),
            child: Row(
              children: [
                VerticalDivider(color: Theme.of(context).iconTheme.color, width: 0),
                const SizedBox(width: AppSpaces.elementSpacing),
                Image(
                  image: (socialLinks[index].icon as Image).image,
                  width: 15,
                  height: 15,
                  color: Theme.of(context).iconTheme.color,
                ),
                const SizedBox(width: AppSpaces.elementSpacing * 0.5),
                EdTexts.bodyText(socialLinks[index].title, context),
                if (index == socialLinks.length - 1) ...[
                  const SizedBox(width: AppSpaces.elementSpacing),
                  VerticalDivider(color: Theme.of(context).iconTheme.color, width: 0),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
