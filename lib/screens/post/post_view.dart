import 'package:flutterfairy/components/avatar.dart';
import 'package:flutterfairy/components/button.dart';
import 'package:flutterfairy/components/display_image.dart';
import 'package:flutterfairy/components/paragraph/paragraph_card.dart';
import 'package:flutterfairy/components/scaffold.dart';
import 'package:flutterfairy/components/texts.dart';
import 'package:flutterfairy/constants/icon_path.dart';
import 'package:flutterfairy/constants/images_path.dart';
import 'package:flutterfairy/constants/lessons.dart';
import 'package:flutterfairy/screens/overview/widgets/appbar.dart';
import 'package:flutterfairy/screens/overview/widgets/post_card.dart';
import 'package:flutterfairy/screens/post/post_state.dart';
import 'package:flutterfairy/theme/colors.dart';
import 'package:flutterfairy/theme/spaces.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PostView extends StatelessWidget {
  final String id;
  const PostView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return ChangeNotifierProvider(
      create: (context) => PostViewState(id),
      child: AppScaffold(
        body: Builder(builder: (context) {
          return ResponsiveBuilder(builder: (context, info) {
            final double padding = info.localWidgetSize.width / AppSpaces.elementSpacing;
            final width = info.isDesktop ? (info.localWidgetSize.width * 0.8) : null;
            final state = context.read<PostViewState>();

            return SizedBox(
              // width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                controller: state.scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    EdAppbar(showMenu: (info.isMobile || info.isTablet)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: AppSpaces.cardPadding),
                          EdTexts.headingMedium(
                            "Theming your flutter application the right way.",
                            context,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(height: AppSpaces.cardPadding),
                          SizedBox(
                            width: info.isDesktop ? (info.localWidgetSize.width * 0.8) : null,
                            child: const ClipRRect(
                              borderRadius: AppSpaces.defaultBorderRadius,
                              child: AspectRatio(
                                aspectRatio: 1.9,
                                child: DisplayImage(
                                  url:
                                      "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjKRJ0JSXxoQ3f-iEOdxSxz4WfIb89djk0Th2JaADQmQYQaPk0cwwJHJP6Ru61P364sDoi4-UUHb9pOv4c5LwXmh-WHPuH5FazOQLqx2TcncIweR3-IZO5fc_C4Eb1jrGhz04mZOmkvdYRor8nDIbFUcEIcae6p04Bf6FTpNVbuC2IKvPWOGVjbwX0yQQ/s1920/Flutter%20UI%20Movies%20Neon%20App.png",
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpaces.elementSpacing),
                          PostAuthCard(width: width, isLight: isLight),
                          const SizedBox(height: AppSpaces.elementSpacing),
                          Container(
                            width: width,
                            padding: const EdgeInsets.all(AppSpaces.elementSpacing),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: AppSpaces.defaultBorderRadius,
                              border: Border.all(
                                width: 1.5,
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                            child: ClipRRect(
                              child: ParagraphCard(
                                lesson: lesson,
                                scrollToPosition: state.scrollToIndex,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpaces.cardPadding),
                          PostAuthCard(width: width, isLight: isLight),
                          const SizedBox(height: kToolbarHeight),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: info.isDesktop ? (info.localWidgetSize.width * 0.1) : padding),
                            child: SizedBox(
                              child: Row(
                                children: [
                                  EdTexts.headingMedium(
                                    "Related Posts",
                                    context,
                                    fontWeight: FontWeight.w600,
                                    center: true,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpaces.elementSpacing),
                          SizedBox(
                            height: 500,
                            child: ListView.builder(
                              itemCount: 4,
                              padding: EdgeInsets.only(
                                  left: info.isDesktop ? (info.localWidgetSize.width * 0.1) : padding, right: padding),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(right: AppSpaces.elementSpacing),
                                child: PostCard(index: index),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        }),
      ),
    );
  }
}

class PostAuthCard extends StatelessWidget {
  const PostAuthCard({
    Key? key,
    required this.width,
    required this.isLight,
  }) : super(key: key);

  final double? width;
  final bool isLight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(AppSpaces.elementSpacing),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: AppSpaces.defaultBorderRadius,
        border: Border.all(
          width: 1.5,
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EdTexts.subHeading(
              "This tutorial goes over checking users entered location and notifying them if we dont service the area",
              context),
          const SizedBox(height: AppSpaces.elementSpacing),
          FittedBox(
            child: Row(
              children: [
                EdButton(
                  title: 'Try quiz',
                  icon: const Icon(
                    Icons.psychology_outlined,
                    color: AppColors.white,
                  ),
                  background: AppColors.green.withOpacity(.8),
                  onPressed: () {},
                ),
                const SizedBox(width: AppSpaces.elementSpacing),
                EdButton(
                  title: 'View Code',
                  icon: Image.asset(
                    IconPaths.github,
                    height: 20,
                    color: !isLight ? AppColors.black : AppColors.white,
                  ),
                  textColor: !isLight ? AppColors.black : AppColors.white,
                  background: isLight ? AppColors.black : AppColors.white,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpaces.elementSpacing),
          Row(
            children: [
              const ProfileAvater(
                url: ImagePaths.edpi,
                local: true,
                size: 60,
              ),
              const SizedBox(width: AppSpaces.elementSpacing),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EdTexts.subHeading("Written by Paul Jeremiah", context),
                  EdTexts.bodyText("CEO and Lead Developer", context),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpaces.elementSpacing),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: 16,
                    color: Theme.of(context).unselectedWidgetColor,
                  ),
                  const SizedBox(width: AppSpaces.elementSpacing * 0.25),
                  EdTexts.subHeadingSmall(
                    '12th Dec. 2022',
                    context,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).unselectedWidgetColor,
                  ),
                ],
              ),
              const SizedBox(width: AppSpaces.elementSpacing),
              Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: 16,
                    color: Theme.of(context).unselectedWidgetColor,
                  ),
                  const SizedBox(width: AppSpaces.elementSpacing * 0.25),
                  EdTexts.subHeadingSmall(
                    '12min',
                    context,
                    color: Theme.of(context).unselectedWidgetColor,
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpaces.elementSpacing),
          Wrap(
            runSpacing: AppSpaces.elementSpacing * 0.5,
            children: List.generate(
              5,
              (index) => Padding(
                padding: const EdgeInsets.only(right: AppSpaces.elementSpacing),
                child: ActionChip(
                  onPressed: () {},
                  avatar: const ProfileAvater(
                    url: IconPaths.github,
                    local: true,
                  ),
                  label: EdTexts.subHeading("Firebase", context),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
