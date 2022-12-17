import 'package:flutter/material.dart';
import 'package:flutterfairy/models/lesson/paragraph.dart';
import 'package:flutterfairy/theme/spaces.dart';

class SeperatorCard extends StatelessWidget {
  final Paragraph paragraph;
  const SeperatorCard({super.key, required this.paragraph});

  @override
  Widget build(BuildContext context) {
    final isSpace = paragraph.content == '/space';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpaces.elementSpacing),
      child: isSpace
          ? const SizedBox(height: 5)
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: AppSpaces.elementSpacing * 0.5),
                  child: Icon(
                    Icons.circle,
                    size: 5,
                    color: Theme.of(context).unselectedWidgetColor,
                  ),
                ),
              ),
            ),
    );
  }
}
