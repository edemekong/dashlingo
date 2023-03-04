import 'package:dashlingo/components/bounce_animation.dart';
import 'package:dashlingo/components/button.dart';
import 'package:dashlingo/components/display_image.dart';
import 'package:dashlingo/components/scaffold.dart';
import 'package:dashlingo/components/texts.dart';
import 'package:dashlingo/constants/images_path.dart';
import 'package:dashlingo/screens/lessons/widgets/answer_card.dart';
import 'package:dashlingo/theme/spaces.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AccountSetup extends StatelessWidget {
  const AccountSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: ResponsiveBuilder(
        builder: (context, info) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpaces.elementSpacing * 0.5),
              Padding(
                padding: const EdgeInsets.only(left: AppSpaces.elementSpacing * 0.5),
                child: CloseButton(
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: AppSpaces.elementSpacing),
              Expanded(
                child: PageView(
                  children: [
                    ChooseYourLevel(info: info),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ChooseYourLevel extends StatelessWidget {
  const ChooseYourLevel({
    Key? key,
    required this.info,
  }) : super(key: key);

  final SizingInformation info;

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
              'Choose your level',
              context,
              fontWeight: FontWeight.w800,
            ),
            const SizedBox(height: AppSpaces.cardPadding),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QuizBoxCard(
                  state: QuizState.selected,
                  title: '',
                  subtitle: '',
                  onTap: () {},
                ),
                const SizedBox(height: AppSpaces.elementSpacing * 0.5),
                QuizBoxCard(
                  state: QuizState.non,
                  title: '',
                  subtitle: '',
                  onTap: () {},
                ),
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

class QuizBoxCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final void Function() onTap;
  final QuizState state;
  const QuizBoxCard({
    Key? key,
    this.state = QuizState.selected,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selected = QuizState.selected == state;
    return BounceAnimation(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(AppSpaces.elementSpacing),
        decoration: BoxDecoration(
          borderRadius: AppSpaces.defaultBorderRadius,
          color: Theme.of(context).cardColor.withOpacity(selected ? .9 : .2),
          border: Border.all(
            width: 1.6,
            color: Theme.of(context).dividerColor,
          ),
        ),
        child: Row(
          children: [
            const DisplayImage(
              url: ImagePaths.dash1,
              width: 60,
              height: 60,
            ),
            const SizedBox(width: AppSpaces.elementSpacing * 0.5),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DashTexts.subHeadingSmall(
                    'Learning Flutter/Dart for the first time?',
                    context,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: AppSpaces.elementSpacing * 0.25),
                  DashTexts.bodyText(
                    'Start from scratch!',
                    context,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpaces.elementSpacing * 0.5),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Theme.of(context).dividerColor,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
