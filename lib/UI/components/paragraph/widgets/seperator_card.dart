import 'package:flutter/material.dart';
import 'package:dashlingo/data/models/learn/paragraph.dart';
import 'package:dashlingo/UI/theme/spaces.dart';

class SeperatorCard extends StatelessWidget {
  final Paragraph paragraph;
  final double size;
  const SeperatorCard({
    super.key,
    required this.paragraph,
    required this.size,
  });

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
                    size: size,
                    color: Theme.of(context).unselectedWidgetColor,
                  ),
                ),
              ),
            ),
    );
  }
}
