import 'package:dashlingo/UI/components/bounce_animation.dart';
import 'package:dashlingo/UI/components/display_image.dart';
import 'package:dashlingo/UI/components/texts.dart';
import 'package:dashlingo/constants/paths.dart';
import 'package:dashlingo/data/services/navigation_service.dart';
import 'package:dashlingo/UI/theme/colors.dart';
import 'package:dashlingo/UI/theme/spaces.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TutorialCard extends StatelessWidget {
  final int index;
  const TutorialCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return SizedBox(
      width: 300,
      child: BounceAnimation(
        reverse: true,
        onTap: () {
          context.push(tutorialPath);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: AppSpaces.defaultBorderRadius.copyWith(
                bottomLeft: Radius.zero,
                bottomRight: Radius.zero,
              ),
              child: const AspectRatio(
                aspectRatio: 2.55,
                child: DisplayImage(
                  url:
                      "https://dl.hiapphere.com/data/thumb/202112/flutter.learnflutter.flutterdevelopment.appdevelopment.mobileapp.development.crossplatform_HiAppHere_com_icon.png",
                ),
              ),
            ),
            const SizedBox(height: AppSpaces.elementSpacing * 0.25),
            Container(
              padding: const EdgeInsets.all(AppSpaces.elementSpacing),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: AppSpaces.defaultBorderRadius.copyWith(
                  topLeft: const Radius.circular(0),
                  topRight: const Radius.circular(0),
                ),
                border: Border.all(
                  width: 1.5,
                  color: Theme.of(context).dividerColor,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).dividerColor,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DashTexts.callout(
                    "Clean custom solution to theming your Flutter app.",
                    context,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: AppSpaces.elementSpacing * 0.5),
                  DashTexts.bodyText(
                    index == 1
                        ? "Theming your flutter app asdasdasdasdasdasd"
                        : "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                    context,
                    maxLines: 3,
                    fontWeight: FontWeight.w300,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpaces.elementSpacing),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: AppSpaces.elementSpacing * 0.5),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: 18,
                                color: Theme.of(context).unselectedWidgetColor,
                              ),
                              const SizedBox(width: AppSpaces.elementSpacing * 0.25),
                              DashTexts.footnote(
                                '12min',
                                context,
                                color: Theme.of(context).unselectedWidgetColor,
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpaces.elementSpacing * 0.25),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                size: 18,
                                color: Theme.of(context).unselectedWidgetColor,
                              ),
                              const SizedBox(width: AppSpaces.elementSpacing * 0.25),
                              DashTexts.footnote(
                                '12th Dec. 2022',
                                context,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).unselectedWidgetColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const CircleAvatar(
                        backgroundColor: AppColors.red,
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
