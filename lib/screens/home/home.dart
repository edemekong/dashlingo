import 'package:flutterfairy/components/button.dart';
import 'package:flutterfairy/components/display_image.dart';
import 'package:flutterfairy/components/scaffold.dart';
import 'package:flutterfairy/components/texts.dart';
import 'package:flutterfairy/screens/overview/widgets/post_card.dart';
import 'package:flutterfairy/theme/colors.dart';
import 'package:flutterfairy/theme/spaces.dart';
import 'package:flutterfairy/utils/logs.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return AppScaffold(
      body: ResponsiveBuilder(builder: (context, info) {
        final double padding = info.localWidgetSize.width / AppSpaces.elementSpacing;
        edPrint(info.localWidgetSize.width);
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppSpaces.cardPadding),
                      EdTexts.headingBig(
                        "Build Flutter apps with ease.",
                        context,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: AppSpaces.elementSpacing),
                      EdTexts.subHeading(
                        "Inspired to give beginners & intermediates where they can always fallback to.",
                        context,
                        fontWeight: FontWeight.w400,
                      ),
                      const SizedBox(height: AppSpaces.cardPadding),
                      SizedBox(
                        width: info.isDesktop ? (info.localWidgetSize.width * 0.6) : null,
                        child: const ClipRRect(
                          borderRadius: AppSpaces.defaultBorderRadius,
                          child: AspectRatio(
                            aspectRatio: 1.9,
                            child: DisplayImage(
                              url:
                                  "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjKRJ0JSXxoQ3f-iEOdxSxz4WfIb89djk0Th2JaADQmQYQaPk0cwwJHJP6Ru61P364sDoi4-UUHb9pOv4c5LwXmh-WHPuH5FazOQLqx2TcncIweR3-IZO5fc_C4Eb1jrGhz04mZOmkvdYRor8nDIbFUcEIcae6p04Bf6FTpNVbuC2IKvPWOGVjbwX0yQQ/s1920/Flutter%20UI%20Movies%20Neon%20App.png",
                              local: false,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpaces.cardPadding),
                Container(
                  color: isLight ? AppColors.lightGrey : AppColors.darkBlue,
                  padding: EdgeInsets.symmetric(
                    vertical: AppSpaces.elementSpacing,
                    horizontal: padding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: EdTexts.subHeading("Test your Dart & Flutter skills", context),
                      ),
                      const SizedBox(width: AppSpaces.cardPadding),
                      EdButton(
                        title: 'Start Quiz',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpaces.cardPadding),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EdTexts.headingMedium(
                        "Featured",
                        context,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: AppSpaces.elementSpacing),
                      Align(
                        alignment: Alignment.topLeft,
                        child: GridView.builder(
                          itemCount: 3,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: info.localWidgetSize.width <= 500
                                ? 1
                                : info.localWidgetSize.width <= 760
                                    ? 2
                                    : (info.isMobile ? 2 : 3),
                            mainAxisSpacing: AppSpaces.elementSpacing,
                            crossAxisSpacing: AppSpaces.elementSpacing,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: 300,
                              child: FittedBox(
                                child: PostCard(
                                  index: index,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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