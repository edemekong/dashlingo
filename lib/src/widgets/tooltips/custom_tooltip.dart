import 'package:flutter/material.dart';

import '../../constants/durations.dart';
import '../../theme/colors.dart';
import '../../theme/spaces.dart';
import '../widget_offset.dart';

class DashToolTipDropdown extends StatefulWidget {
  final Widget child;
  final Widget icon;
  final Color? backgroundColor;
  final double? width;

  const DashToolTipDropdown(
      {Key? key, required this.child, required this.icon, color, this.backgroundColor, this.width})
      : super(key: key);

  @override
  State<DashToolTipDropdown> createState() => _MedallaToolTipDropdownState();
}

class _MedallaToolTipDropdownState extends State<DashToolTipDropdown> with TickerProviderStateMixin {
  // final UIService _uiService = locate<UIService>();
  Offset _mainOffset = Offset.zero;
  Size _mainSide = Size.zero;

  bool onHover = false;

  AnimationController? _controller;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: AppDurations.fast);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  OverlayEntry _makeOverlay() {
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (mounted) _controller?.reverse();
              // _uiService.unsetOverlay();
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
            ),
          ),
          Positioned(
            top: _mainOffset.dy + AppSpaces.cardPadding,
            right: _mainSide.width + AppSpaces.cardPadding,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.5, end: 0.9)
                  .animate(CurvedAnimation(parent: _controller!, curve: Curves.easeOutCubic)),
              child: ToolTipDropdown(
                widget: widget.child,
                width: widget.width,
                color: widget.backgroundColor ?? Theme.of(context).canvasColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WidgetOffset(
      onOffsetChanged: (offset) => _mainOffset = offset,
      onSizedChanged: (size) => _mainSide = size,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
          borderRadius: AppSpaces.defaultBorderRadius,
          onTap: () {
            // if (!_uiService.hasOverlay) {
            //   Overlay.of(context).insert(_uiService.createOverlay(_makeOverlay()));
            //   _controller?.forward();
            // } else {
            //   _controller?.reverse().then((value) {
            //     // _uiService.unsetOverlay();
            //   });
            // }
          },
          child: widget.icon,
        ),
      ),
    );
  }
}

class ToolTipDropdown extends StatelessWidget {
  final Color? color;

  final double? width;

  const ToolTipDropdown({
    Key? key,
    required this.widget,
    this.color,
    this.width,
  }) : super(key: key);

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: AppSpaces.defaultBorderRadius,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: AppSpaces.elementSpacing,
          horizontal: AppSpaces.elementSpacing * 1.5,
        ),
        child: widget,
      ),
    );
  }
}
