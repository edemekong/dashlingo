import 'dart:async';

import 'package:dashlingo/components/avatar.dart';
import 'package:dashlingo/components/button.dart';
import 'package:dashlingo/components/display_image.dart';
import 'package:dashlingo/components/scaffold.dart';
import 'package:dashlingo/components/texts.dart';
import 'package:dashlingo/constants/icon_path.dart';
import 'package:dashlingo/constants/paths.dart';
import 'package:dashlingo/models/user.dart';
import 'package:dashlingo/repositories/user_repository.dart';
import 'package:dashlingo/states/auth_state.dart';
import 'package:dashlingo/theme/colors.dart';
import 'package:dashlingo/theme/spaces.dart';
import 'package:dashlingo/utils/logs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../constants/mocks/steps.dart';
import '../../models/learn/lesson.dart';
import '../../models/learn/step.dart';
import '../../services/navigation_service.dart';

const List<Color> colors = [
  AppColors.primaryColor,
  AppColors.orange,
  AppColors.pink,
  AppColors.cyen,
  AppColors.brown,
  AppColors.red,
  AppColors.lightPink,
  AppColors.purple,
  AppColors.primaryColor,
  AppColors.red,
];

class LearnView extends StatefulWidget {
  const LearnView({super.key});

  @override
  State<LearnView> createState() => _LearnViewState();
}

class _LearnViewState extends State<LearnView> {
  @override
  Widget build(BuildContext context) {
    final User? currentUser = context.select<AuthState, User?>((v) => v.currentUser);

    return AppScaffold(
      body: ResponsiveBuilder(builder: (context, info) {
        final double padding = info.localWidgetSize.width / AppSpaces.elementSpacing;

        // return AccountSetup();
        return SizedBox(
          width: info.screenSize.width,
          height: MediaQuery.of(context).size.height,
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  primary: true,
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: padding),
                  child: Column(
                    children: List.generate(
                      steps.length + 1,
                      (i) {
                        if (i == 0) {
                          if (info.isDesktop || info.isTablet) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: AppSpaces.cardPadding),
                            child: ProfileCard(currentUser: currentUser),
                          );
                        }

                        final index = i - 1;

                        return StepView(
                          color: colors[(index) % steps.length],
                          info: info,
                          step: steps[index],
                          count: (index) + 1,
                        );
                      },
                    ),
                  ),
                ),
              ),
              if (info.screenSize.width >= 768) ...[
                SizedBox(
                  width: (info.screenSize.width - 100) * 0.3,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.only(
                      right: AppSpaces.elementSpacing,
                      top: AppSpaces.elementSpacing,
                      left: AppSpaces.elementSpacing * 0.5,
                    ),
                    child: ProfileCard(currentUser: currentUser),
                  ),
                ),
              ],
            ],
          ),
        );
      }),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.currentUser,
  });

  final User? currentUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpaces.elementSpacing),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).dividerColor,
            ),
            borderRadius: AppSpaces.defaultBorderRadius,
          ),
          child: Builder(builder: (context) {
            if (currentUser != null) {
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileAvater(
                        url: currentUser!.profileImageUrl,
                        size: 60,
                      ),
                      const SizedBox(width: AppSpaces.elementSpacing * 0.5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DashTexts.headingSmall(currentUser!.name, context),
                            DashTexts.subHeading('@${currentUser!.handle}', context),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpaces.elementSpacing),
                  DashButton(
                    title: ('View Profile'),
                    icon: const Icon(CupertinoIcons.profile_circled, color: AppColors.white),
                    background: AppColors.green,
                    onPressed: () {},
                  ),
                ],
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DashTexts.headingSmall(
                  'Create a profile to save your progress!',
                  context,
                ),
                const SizedBox(height: AppSpaces.cardPadding),
                DashButton(
                  title: ('Sign in with Google'),
                  icon: const Padding(
                    padding: EdgeInsets.only(right: AppSpaces.elementSpacing * 0.25),
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: DisplayImage(url: IconPaths.google),
                    ),
                  ),
                  background: AppColors.green,
                  onPressed: () {
                    UserRepository.instance.siginWithGoogle().then((value) {
                      if (value.isRight) {
                        dashPrint(value.right);
                      } else {
                        dashPrint(value.left);
                      }
                    });
                  },
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}

class StepView extends StatelessWidget {
  final int count;
  final DashStep step;
  final Color color;

  const StepView({Key? key, required this.info, required this.step, required, required this.color, required this.count})
      : super(key: key);

  final SizingInformation info;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: AppSpaces.elementSpacing),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpaces.elementSpacing,
            vertical: AppSpaces.cardPadding * 0.65,
          ),
          decoration: BoxDecoration(
            borderRadius: AppSpaces.defaultBorderRadius,
            color: color,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DashTexts.headingSmall(
                      "Step $count",
                      context,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                    const SizedBox(height: AppSpaces.elementSpacing * 0.5),
                    DashTexts.subHeading(
                      step.description,
                      context,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 120,
                child: DashButton(
                  title: 'TUTORIALS',
                  background: color,
                  icon: const Icon(
                    Icons.book,
                    color: AppColors.white,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: info.screenSize.shortestSide * ((step.lessons.length + 1.5) * 0.15),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: List.generate(
              step.lessons.length,
              (index) {
                final Lesson lesson = step.lessons[index];
                final value = info.localWidgetSize.width / 8;
                final isNext3 = index % 2 == 0;

                return Positioned(
                  left: isNext3 ? 0 : value,
                  right: isNext3 ? value : 0,
                  top: index == 0 ? (index + 1) * 100 : (index + 1) * 130,
                  child: LessonButton(
                    color: color,
                    state: index == 0 ? LessonButtonState.initial : LessonButtonState.disabled,
                    lesson: lesson,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

enum LessonButtonState { initial, disabled, completed }

class LessonButton extends StatefulWidget {
  final Color color;
  final LessonButtonState state;
  const LessonButton({
    Key? key,
    required this.state,
    required Lesson lesson,
    required this.color,
  }) : super(key: key);

  @override
  State<LessonButton> createState() => _LessonButtonState();
}

class _LessonButtonState extends State<LessonButton> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> offsetAnimation;

  bool toggle = false;
  Timer? _timer;

  bool get isDisabled => [LessonButtonState.disabled].contains(widget.state);

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    offsetAnimation = Tween<double>(
      begin: -50,
      end: -45,
    ).animate(animationController);
    animate();
  }

  void animate() {
    if (isDisabled) return;
    _timer?.cancel();
    _timer = null;
    _timer = Timer.periodic(const Duration(milliseconds: 900), (_) {
      if (animationController.isCompleted) {
        animationController.reverse();
      } else {
        animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double square = 80;
    return Column(
      children: [
        SizedBox(
          width: square,
          height: square,
          child: Stack(
            fit: StackFit.loose,
            clipBehavior: Clip.none,
            children: [
              Center(
                child: CustomPaint(
                  painter: DrawLessonButtonPainter(
                    toggle: toggle,
                    color: isDisabled ? Theme.of(context).cardColor : widget.color,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      context.push(path(
                        lessonPath,
                        queryParameters: {
                          "step": '1',
                        },
                      ));
                    },
                    onTapUp: (_) {
                      toggle = false;
                      setState(() {});
                    },
                    onTapDown: (_) {
                      toggle = true;
                      setState(() {});
                    },
                    child: Container(
                      color: Colors.transparent,
                      height: square,
                      width: square,
                      child: Align(
                        alignment: toggle ? const Alignment(0, 0.19) : const Alignment(0, -0.3),
                        child: Icon(
                          isDisabled ? Icons.lock : Icons.star_rounded,
                          size: 40,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (!isDisabled) ...[
                AnimatedBuilder(
                  animation: offsetAnimation,
                  builder: (context, child) {
                    return Positioned(
                      left: -8,
                      top: offsetAnimation.value,
                      child: child!,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpaces.elementSpacing,
                      vertical: AppSpaces.elementSpacing * 0.5,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: AppSpaces.defaultBorderRadiusTextField,
                      color: Theme.of(context).cardColor,
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                    child: DashTexts.subHeading(
                      'START',
                      context,
                      fontWeight: FontWeight.w600,
                      color: widget.color,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        if (!isDisabled) ...[
          const SizedBox(height: AppSpaces.elementSpacing * 0.5),
          FittedBox(
            child: Row(
              children: [
                SizedBox(
                  width: square * 0.6,
                  child: Container(
                    height: 10,
                    width: square * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: AppSpaces.defaultBorderRadius,
                      color: AppColors.white.darken(0.2),
                    ),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          height: 10,
                          width: (50 / 100) * (square * 0.8),
                          decoration: BoxDecoration(
                            color: widget.color,
                            borderRadius: AppSpaces.defaultBorderRadius,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: AppSpaces.elementSpacing * 0.5),
                DashTexts.bodyText('10%', context, fontWeight: FontWeight.w600)
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class DrawLessonButtonPainter extends CustomPainter {
  final bool toggle;
  final Color color;
  DrawLessonButtonPainter({
    this.toggle = false,
    this.color = AppColors.orange,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint darkBrush = Paint()
      ..color = color.darken(0.07)
      ..style = PaintingStyle.fill;

    Paint mediumBrush = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(0, 10, size.width, size.height),
        AppSpaces.defaultBorderRadius.bottomLeft,
      ),
      darkBrush,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(0, toggle ? 10 : 0, size.width, toggle ? size.height : size.height * 0.85),
        AppSpaces.defaultBorderRadius.bottomLeft,
      ),
      mediumBrush,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class LearnViewWidget extends StatelessWidget {
  const LearnViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const LearnView();
  }
}
