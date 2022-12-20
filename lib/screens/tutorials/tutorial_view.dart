import 'package:dashlingo/components/bounce_animation.dart';
import 'package:dashlingo/components/scaffold.dart';
import 'package:dashlingo/components/textfield.dart';
import 'package:dashlingo/components/texts.dart';
import 'package:dashlingo/screens/overview/widgets/tutorial_card.dart';
import 'package:dashlingo/screens/tutorials/tutorials_state.dart';
import 'package:dashlingo/theme/colors.dart';
import 'package:dashlingo/theme/spaces.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TutorialsViewBody extends StatelessWidget {
  const TutorialsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final state = context.watch<TutorialsState>();

    return Builder(builder: (context) {
      return AppScaffold(
        body: Builder(builder: (context) {
          return ResponsiveBuilder(builder: (context, info) {
            final double padding = info.localWidgetSize.width / AppSpaces.elementSpacing;
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
                          DashTexts.headingBig(
                            "Flutter & Dart Tutorials",
                            context,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(height: AppSpaces.elementSpacing),
                          DashTexts.subHeading(
                            "Learn cross platform development from the world's top cross platform sdk's",
                            context,
                            fontWeight: FontWeight.w400,
                          ),
                          const SizedBox(height: AppSpaces.cardPadding),
                          Row(
                            children: const [
                              Expanded(
                                flex: 3,
                                child: EdTextfield(
                                  hintText: 'Search tutorials',
                                  showClear: true,
                                  maxLines: 1,
                                  padding: EdgeInsets.zero,
                                  prefix: Icon(Icons.search),
                                ),
                              ),
                              Spacer(),
                            ],
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
                                child: TutorialCard(
                                  index: index,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpaces.cardPadding),
                    const Divider(thickness: 1.5, height: 0),
                    Container(
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
                                child: DashTexts.subHeading('${index + 1}', context,
                                    color: selected && isLight ? AppColors.white : null),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const Divider(thickness: 1.5, height: 0),
                    const SizedBox(height: AppSpaces.cardPadding * 2),
                  ],
                ),
              ),
            );
          });
        }),
      );
    });
  }
}

class TutorialsView extends StatelessWidget {
  final String id;
  const TutorialsView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TutorialsState(id),
      child: const TutorialsViewBody(),
    );
  }
}
