import 'dart:async';

import 'package:dashlingo/components/button.dart';
import 'package:dashlingo/components/scaffold.dart';
import 'package:dashlingo/components/texts.dart';
import 'package:dashlingo/constants/paths.dart';
import 'package:dashlingo/services/navigation_service.dart';
import 'package:dashlingo/theme/colors.dart';
import 'package:dashlingo/theme/spaces.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LearnView extends StatefulWidget {
  const LearnView({super.key});

  @override
  State<LearnView> createState() => _LearnViewState();
}

class _LearnViewState extends State<LearnView> {
  // bool toggle = false;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: ResponsiveBuilder(builder: (context, info) {
        final double padding = info.localWidgetSize.width / AppSpaces.elementSpacing;
        final screenWidth = info.localWidgetSize.width;
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: SizedBox(
            width: info.localWidgetSize.width * 0.8,
            height: MediaQuery.of(context).size.height * 2.2,
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: List.generate(
                      10,
                      (index) {
                        final value = screenWidth / 8;
                        final isNext3 = index % 2 == 0;

                        return Positioned(
                          left: isNext3 ? 0 : value,
                          right: isNext3 ? value : 0,
                          bottom: (index + 1) * 180,
                          child: const LessonButton(),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class LessonButton extends StatefulWidget {
  const LessonButton({
    Key? key,
  }) : super(key: key);

  @override
  State<LessonButton> createState() => _LessonButtonState();
}

class _LessonButtonState extends State<LessonButton> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> offsetAnimation;
  bool toggle = false;
  Timer? _timer;

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

  animate() {
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
            // fit: StackFit.loose,
            clipBehavior: Clip.none,
            children: [
              Center(
                child: CustomPaint(
                  painter: DrawLessonButtonPainter(
                    toggle: toggle,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: GestureDetector(
                    onTap: () {},
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
                          Icons.star_rounded,
                          size: 50,
                          color: AppColors.white.darken(0.1),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: offsetAnimation,
                builder: (context, child) {
                  return Positioned(
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
                  child: FairyTexts.subHeading(
                    'START',
                    context,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
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
                          color: Theme.of(context).primaryColor,
                          borderRadius: AppSpaces.defaultBorderRadius,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSpaces.elementSpacing * 0.5),
              FairyTexts.bodyText('10%', context, fontWeight: FontWeight.w600)
            ],
          ),
        ),
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
