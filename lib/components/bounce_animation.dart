import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BounceAnimation extends StatefulWidget {
  final Widget child;
  final bool reverse;

  final void Function()? onTap;

  final void Function()? onLongPress;

  final void Function(PointerExitEvent)? onExit;

  final void Function(DragUpdateDetails)? onHorizontalDragUpdate;

  final Function(PointerHoverEvent)? onHover;

  const BounceAnimation({
    Key? key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.onHorizontalDragUpdate,
    this.onHover,
    this.onExit,
    this.reverse = false,
  }) : super(key: key);

  @override
  State<BounceAnimation> createState() => _BounceAnimationState();
}

class _BounceAnimationState extends State<BounceAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.05,
    );

    _controller.addListener(() {
      setState(() {});
    });

    if (!mounted) {
      _controller.dispose();
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller.removeListener(() {
      setState(() {});
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (v) {
        if (widget.onHover != null) {
          widget.onHover!(v);
        }
        _controller.forward();
      },
      onExit: (v) {
        if (widget.onExit != null) {
          widget.onExit!(v);
        }
        _controller.reverse();
      },
      child: GestureDetector(
        onHorizontalDragUpdate: widget.onHorizontalDragUpdate,
        onTapDown: (v) {
          if (widget.onTap != null) {
            HapticFeedback.selectionClick();
            if (widget.reverse) {
              return;
            }
            _controller.forward();
          }
        },
        onTapUp: (v) {
          if (widget.onTap != null) {
            if (widget.reverse) {
              return;
            }
            _controller.reverse();
          }
        },
        onPanDown: (v) {
          if (widget.onTap != null) {
            if (widget.reverse) {
              return;
            }
            _controller.forward();
          }
        },
        onPanCancel: () {
          if (widget.onTap != null) {
            if (widget.reverse) {
              return;
            }
            _controller.reverse();
          }
        },
        onPanEnd: (v) {
          if (widget.onTap != null) {
            _controller.reverse();
          }
        },
        onLongPress: widget.onLongPress,
        onTap: widget.onTap,
        child: Transform.scale(
          scale: widget.reverse ? 1 + _controller.value : 1 - _controller.value,
          child: widget.child,
        ),
      ),
    );
  }
}
