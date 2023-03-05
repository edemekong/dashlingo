import 'package:dashlingo/components/button.dart';
import 'package:dashlingo/components/texts.dart';
import 'package:dashlingo/screens/account_setup/components/contents.dart';
import 'package:dashlingo/screens/lessons/widgets/answer_card.dart';
import 'package:dashlingo/theme/spaces.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../lessons/widgets/selectable_box_card.dart';

class SelectUserInterest extends StatelessWidget {
  const SelectUserInterest({
    Key? key,
    required this.info,
    this.pageData = const [],
    required this.title,
  }) : super(key: key);

  final SizingInformation info;
  final String title;
  final List<UserInterest> pageData;

  @override
  Widget build(BuildContext context) {
    final double padding = info.localWidgetSize.width / AppSpaces.elementSpacing;
    final width = info.isDesktop ? (info.localWidgetSize.width * 0.65) : null;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashTexts.headingSmall(
              title,
              context,
              fontWeight: FontWeight.w800,
            ),
            const SizedBox(height: AppSpaces.cardPadding),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < pageData.length; i++) ...[
                  SelectableBoxCard(
                    state: QuizState.selected,
                    title: pageData[i].title,
                    subtitle: pageData[i].description,
                    onTap: () {},
                  ),
                  const SizedBox(height: AppSpaces.elementSpacing * 0.5),
                ],
              ],
            ),
            const SizedBox(height: AppSpaces.cardPadding * 2),
            DashButton(
              title: 'CONTINUE',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
