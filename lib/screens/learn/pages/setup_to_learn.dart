import 'package:flutter/material.dart';
import 'package:flutterfairy/components/scaffold.dart';
import 'package:flutterfairy/components/texts.dart';
import 'package:flutterfairy/screens/learn/learn_state.dart';
import 'package:flutterfairy/theme/spaces.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SetUpToLearn extends StatelessWidget {
  const SetUpToLearn({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: ResponsiveBuilder(builder: (context, info) {
        final double padding = info.localWidgetSize.width / AppSpaces.elementSpacing;
        final width = info.isDesktop ? (info.localWidgetSize.width * 0.8) : null;

        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: AppSpaces.cardPadding),
                EdTexts.headingSmall("Choose your path", context),
                const SizedBox(height: AppSpaces.cardPadding * 2),
                ...List.generate(
                  2,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpaces.elementSpacing),
                    child: EdQuizCard(),
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

class EdQuizCard extends StatelessWidget {
  const EdQuizCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 500,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: AppSpaces.defaultBorderRadius,
        border: Border.all(
          width: 1.5,
          color: Theme.of(context).dividerColor,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).dividerColor,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );
  }
}
