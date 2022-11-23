import 'package:flutterfairy/components/display_image.dart';
import 'package:flutterfairy/components/scaffold.dart';
import 'package:flutterfairy/components/texts.dart';
import 'package:flutterfairy/screens/post/post_state.dart';
import 'package:flutterfairy/theme/spaces.dart';
import 'package:flutter/material.dart';
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
                        local: false,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpaces.cardPadding),
                Container(
                  width: width,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: AppSpaces.defaultBorderRadius,
                  ),
                ),
                const SizedBox(height: AppSpaces.elementSpacing),
                Container(
                  width: width,
                  height: 1000,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: AppSpaces.defaultBorderRadius,
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
