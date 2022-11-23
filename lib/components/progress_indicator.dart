import 'package:flutterfairy/theme/colors.dart';
import 'package:flutter/material.dart';

class EdCircularProgressIndicator extends StatelessWidget {
  final Color? color;
  const EdCircularProgressIndicator({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.scale(
        scale: 0.6,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(color ?? AppColors.white),
        ),
      ),
    );
  }
}
