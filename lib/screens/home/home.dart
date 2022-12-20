import 'package:dashlingo/components/button.dart';
import 'package:dashlingo/components/display_image.dart';
import 'package:dashlingo/components/scaffold.dart';
import 'package:dashlingo/components/texts.dart';
import 'package:dashlingo/screens/overview/widgets/appbar.dart';
import 'package:dashlingo/screens/overview/widgets/tutorial_card.dart';
import 'package:dashlingo/theme/colors.dart';
import 'package:dashlingo/theme/spaces.dart';
import 'package:dashlingo/utils/logs.dart';
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
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
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
                            DashTexts.headingBig(
                              "Build Flutter apps with ease.",
                              context,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(height: AppSpaces.elementSpacing),
                            DashTexts.subHeading(
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
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpaces.cardPadding),
                      Divider(thickness: 1.5, color: Theme.of(context).dividerColor, height: 0),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: AppSpaces.elementSpacing,
                          horizontal: padding,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: DashTexts.subHeading("Test your Dart & Flutter skills", context),
                            ),
                            const SizedBox(width: AppSpaces.cardPadding),
                            DashButton(
                              title: 'Start Quiz',
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      Divider(thickness: 1.5, color: Theme.of(context).dividerColor, height: 0),
                      const SizedBox(height: AppSpaces.cardPadding),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: padding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DashTexts.headingMedium(
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
                                      child: TutorialCard(
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
              ),
            ],
          ),
        );
      }),
    );
  }
}
