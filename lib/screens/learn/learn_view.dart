import 'package:dashlingo/components/button.dart';
import 'package:dashlingo/components/scaffold.dart';
import 'package:dashlingo/components/texts.dart';
import 'package:dashlingo/theme/colors.dart';
import 'package:dashlingo/theme/spaces.dart';
import 'package:dashlingo/utils/logs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../components/stepper.dart';

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
                    bottom: (index + 1) * 150,
                    child: const LessonButton(),
                  );
                },
              ),
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

class _LessonButtonState extends State<LessonButton> {
  bool toggle = false;

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
            children: [
              Center(
                child: CustomPaint(
                  painter: DrawLessonButtonPainter(
                    toggle: toggle,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: GestureDetector(
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
