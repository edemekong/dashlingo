import 'package:flutterfairy/theme/colors.dart';
import 'package:flutterfairy/utils/logs.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/theme.dart';

class DisplayImage extends StatelessWidget {
  final String? url;
  final double aspectRatio;
  final double? width;
  final double? height;
  final double iconSize;
  final Widget icon;
  final BoxFit? fit;
  final bool local;
  final Function(LoadState)? status;

  const DisplayImage({
    Key? key,
    required this.url,
    this.aspectRatio = 1,
    this.width,
    this.height,
    this.iconSize = 120.0,
    this.icon = const Icon(Icons.image_search_outlined, size: 40),
    this.fit,
    this.status,
    this.local = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (url != null && url != '') {
        if (local) {
          return ExtendedImage.asset(
            url!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            enableLoadState: true,
            loadStateChanged: (state) {
              if (status != null) {
                status!(state.extendedImageLoadState);
              }

              switch (state.extendedImageLoadState) {
                case LoadState.completed:
                  return state.completedWidget;
                case LoadState.loading:
                  return _isLoading(context);
                case LoadState.failed:
                default:
                  return _buildError(context);
              }
            },
          );
        }
        return ExtendedImage.network(
          url!,
          cache: true,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          enableLoadState: true,
          printError: false,
          loadStateChanged: (state) {
            if (status != null) {
              status!(state.extendedImageLoadState);
            }

            switch (state.extendedImageLoadState) {
              case LoadState.completed:
                return state.completedWidget;
              case LoadState.loading:
                return _isLoading(context);
              case LoadState.failed:
              default:
                return _buildError(context);
            }
          },
        );
      }
      return _buildError(context);
    });
  }

  Widget _buildError(BuildContext context) {
    final isLight = AppTheme.instance.isLightMode(context);
    return Container(
      color: isLight ? AppColors.lightGrey : AppColors.darkBlue,
      child: IconTheme(
        data: Theme.of(context).iconTheme.copyWith(
              color: isLight ? AppColors.mediumGrey : AppColors.mediumGrey,
            ),
        child: icon,
      ),
    );
  }

  Widget _isLoading(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).canvasColor.withOpacity(.8),
      highlightColor: Theme.of(context).canvasColor,
      enabled: true,
      direction: ShimmerDirection.ltr,
      child: Container(
        color: Theme.of(context).canvasColor,
        child: icon,
      ),
    );
  }
}
