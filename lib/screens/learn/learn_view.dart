import 'dart:async';

import 'package:dashlingo/components/button.dart';
import 'package:dashlingo/components/scaffold.dart';
import 'package:dashlingo/components/texts.dart';
import 'package:dashlingo/constants/paths.dart';
import 'package:dashlingo/theme/colors.dart';
import 'package:dashlingo/theme/spaces.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    return AppScaffold(
      body: ResponsiveBuilder(builder: (context, info) {
        final double padding = info.localWidgetSize.width / AppSpaces.elementSpacing;
        final screenWidth = info.localWidgetSize.width;
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: SizedBox(
            width: info.localWidgetSize.width,
            child: Column(
                children: List.generate(steps.length, (index) {
              return StepView(
                color: colors[index % steps.length],
                screenWidth: screenWidth,
                step: steps[index],
                count: index + 1,
              );
            })),
          ),
        );
      }),
    );
  }
}

class StepView extends StatelessWidget {
  final int count;
  final DashStep step;
  final Color color;

  const StepView(
      {Key? key, required this.screenWidth, required this.step, required, required this.color, required this.count})
      : super(key: key);

  final double screenWidth;

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
          height: MediaQuery.of(context).size.height * ((step.lessons.length + 1.5) * 0.15),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: List.generate(
              step.lessons.length,
              (index) {
                final Lesson lesson = step.lessons[index];
                final value = screenWidth / 8;
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
