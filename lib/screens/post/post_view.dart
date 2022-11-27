import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutterfairy/components/avatar.dart';
import 'package:flutterfairy/components/button.dart';
import 'package:flutterfairy/components/display_image.dart';
import 'package:flutterfairy/components/scaffold.dart';
import 'package:flutterfairy/components/texts.dart';
import 'package:flutterfairy/constants/icon_path.dart';
import 'package:flutterfairy/constants/images_path.dart';
import 'package:flutterfairy/screens/post/md.dart';
import 'package:flutterfairy/screens/post/post_state.dart';
import 'package:flutterfairy/theme/colors.dart';
import 'package:flutterfairy/theme/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutterfairy/utils/logs.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PostView extends StatelessWidget {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return AppScaffold(
      body: ResponsiveBuilder(builder: (context, info) {
        final double padding = info.localWidgetSize.width / AppSpaces.elementSpacing;
        final width = info.isDesktop ? (info.localWidgetSize.width * 0.8) : null;

        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: AppSpaces.cardPadding),
                EdTexts.headingMedium(
                  "Theming your flutter application the right way.",
                  context,
                  fontWeight: FontWeight.w600,
                  center: true,
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
                Container(
                  width: width,
                  padding: const EdgeInsets.all(AppSpaces.cardPadding),
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
                      Row(
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
                          const Spacer(),
                          // ...List.generate(
                          //   3,
                          //   (index) => Padding(
                          //     padding: const EdgeInsets.only(right: AppSpaces.elementSpacing),
                          //     child: ActionChip(
                          //       onPressed: () {},
                          //       avatar: const ProfileAvater(
                          //         url: IconPaths.github,
                          //         local: true,
                          //       ),
                          //       label: EdTexts.subHeading("Firebase", context),
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpaces.elementSpacing),
                Container(
                  width: width,
                  padding: const EdgeInsets.all(AppSpaces.cardPadding),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: AppSpaces.defaultBorderRadius,
                    border: Border.all(
                      width: 1.5,
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                  child: ClipRRect(
                    child: MarkdownBody(
                      data: md,
                      selectable: true,
                      imageBuilder: (uri, title, alt) {
                        edPrint("URIZX ${uri.toString()}");
                        return DisplayImage(
                          url: uri.toString(),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: kToolbarHeight),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class PostViewWidget extends StatelessWidget {
  final String id;
  const PostViewWidget({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PostViewState(id),
      child: const PostView(),
    );
  }
}
