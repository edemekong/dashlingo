import 'package:flutter/material.dart';
import 'package:dashlingo/src/widgets/display_image.dart';
import 'package:dashlingo/src/features/learn/data/models/learn/paragraph.dart';
import 'package:dashlingo/src/theme/spaces.dart';

class ImageCard extends StatelessWidget {
  final Paragraph paragraph;
  const ImageCard({super.key, required this.paragraph});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: paragraph.aspectRatio ?? 1.9,
      child: ClipRRect(
        borderRadius: AppSpaces.defaultBorderRadius,
        child: DisplayImage(
          url: paragraph.content,
        ),
      ),
    );
  }
}
