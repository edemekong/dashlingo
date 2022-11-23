import 'package:flutterfairy/components/bounce_animation.dart';
import 'package:flutterfairy/components/scaffold.dart';
import 'package:flutterfairy/components/texts.dart';
import 'package:flutterfairy/screens/overview/widgets/post_card.dart';
import 'package:flutterfairy/screens/posts/post_state.dart';
import 'package:flutterfairy/theme/colors.dart';
import 'package:flutterfairy/theme/spaces.dart';
import 'package:flutterfairy/utils/logs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PostsView extends StatelessWidget {
  const PostsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final state = context.watch<PostsState>();

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
                        postRouteData[state.id]?['title'] ?? '',
                        context,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: AppSpaces.elementSpacing),
                      EdTexts.subHeading(
                        postRouteData[state.id]?['description'] ?? '',
                        context,
                        fontWeight: FontWeight.w400,
                      ),
                      const SizedBox(height: AppSpaces.cardPadding),
                      GridView.builder(
                        itemCount: 6,
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
                          return FittedBox(
                            child: PostCard(
                              index: index,
                            ),
                          );
                        },
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) {
                        final selected = index == 0;
                        return BounceAnimation(
                          child: Container(
                            margin: const EdgeInsets.only(right: AppSpaces.elementSpacing),
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpaces.elementSpacing * 0.5,
                              vertical: AppSpaces.elementSpacing * 0.15,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: AppSpaces.defaultBorderRadius,
                              color: selected ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
                            ),
                            child: EdTexts.subHeading('${index + 1}', context,
                                color: selected && isLight ? AppColors.white : null),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: AppSpaces.cardPadding * 2),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class PostsViewWidget extends StatelessWidget {
  final String id;
  const PostsViewWidget({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PostsState(id),
      child: const PostsView(),
    );
  }
}
