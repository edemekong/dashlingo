import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DisplayImage extends StatefulWidget {
  final String? url;
  final double aspectRatio;
  final double? width;
  final double? height;
  final double iconSize;
  final Widget icon;
  final BoxFit? fit;

  final Color? backgroundColor;
  final Function(LoadState)? status;

  const DisplayImage({
    Key? key,
    required this.url,
    this.backgroundColor,
    this.aspectRatio = 1,
    this.width,
    this.height,
    this.iconSize = 120.0,
    this.icon = const Icon(Icons.image_search_outlined, size: 40),
    this.fit,
    this.status,
  }) : super(key: key);

  @override
  State<DisplayImage> createState() => _DisplayImageState();
}

class _DisplayImageState extends State<DisplayImage> with AutomaticKeepAliveClientMixin<DisplayImage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    bool isFromNetwork = widget.url!.startsWith('https://');
    return Builder(builder: (context) {
      if (widget.url != null && widget.url != '') {
        if (!isFromNetwork) {
          return ExtendedImage.asset(
            widget.url!,
            height: widget.height,
            width: widget.width,
            fit: widget.fit ?? BoxFit.cover,
            color: widget.backgroundColor,
            enableLoadState: true,
            loadStateChanged: (state) {
              if (widget.status != null) {
                widget.status!(state.extendedImageLoadState);
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
          widget.url!,
          cache: true,
          height: widget.height,
          width: widget.width,
          color: widget.backgroundColor,
          fit: widget.fit ?? BoxFit.cover,
          enableLoadState: true,
          printError: false,
          loadStateChanged: (state) {
            if (widget.status != null) {
              widget.status!(state.extendedImageLoadState);
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
    return Container(
      color: Theme.of(context).cardColor,
      child: IconTheme(
        data: Theme.of(context).iconTheme.copyWith(
              color: Theme.of(context).canvasColor,
            ),
        child: widget.icon,
      ),
    );
  }

  Widget _isLoading(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).cardColor.withOpacity(.8),
      highlightColor: Theme.of(context).cardColor,
      enabled: true,
      direction: ShimmerDirection.ltr,
      child: Container(
        color: Theme.of(context).cardColor,
        child: widget.icon,
      ),
    );
  }
}
