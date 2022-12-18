import 'package:flutter/material.dart';
import 'package:dashlingo/components/display_image.dart';
import 'package:dashlingo/models/lesson/paragraph.dart';
import 'package:dashlingo/theme/spaces.dart';

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
