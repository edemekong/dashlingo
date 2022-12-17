import 'package:flutter/material.dart';
import 'package:flutterfairy/theme/colors.dart';
import 'package:flutterfairy/theme/spaces.dart';

class StepperProgressBar extends StatelessWidget {
  final int count;
  final double width;
  final Color? background;
  final double height;

  const StepperProgressBar({
    Key? key,
    required this.count,
    this.width = double.infinity,
    this.height = 6,
    this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRaduis = BorderRadius.circular(15);

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: borderRaduis,
        color: background ?? Theme.of(context).dividerColor,
      ),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: height,
            width: (count / 100) * (width),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: borderRaduis,
            ),
            child: FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: AppSpaces.elementSpacing),
                    height: height * 0.25,
                    width: (count / 100) * (width) * 0.9,
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(.1),
                      borderRadius: AppSpaces.defaultBorderRadius,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
