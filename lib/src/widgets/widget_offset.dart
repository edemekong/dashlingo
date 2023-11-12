import 'package:flutter/material.dart';

class WidgetOffset extends StatefulWidget {
  final Widget child;
  final Function(Offset offset) onOffsetChanged;
  final Function(Size size)? onSizedChanged;

  const WidgetOffset({Key? key, required this.child, required this.onOffsetChanged, this.onSizedChanged})
      : super(key: key);

  @override
  State<WidgetOffset> createState() => _BoxOffsetState();
}

class _BoxOffsetState extends State<WidgetOffset> {
  Offset offset = const Offset(0.0, 0.0);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = context.findRenderObject() as RenderBox;
      Offset newOffset = box.localToGlobal(Offset.zero);
      if (newOffset != offset) {
        offset = newOffset;
        widget.onOffsetChanged(
          offset,
        );
      }

      if (widget.onSizedChanged != null) {
        widget.onSizedChanged!(box.size);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (v) {
        final box = context.findRenderObject() as RenderBox;
        Offset newOffset = box.localToGlobal(Offset.zero);
        if (newOffset != offset) {
          offset = newOffset;
          widget.onOffsetChanged(offset);
        }
      },
      child: SizedBox(
        child: widget.child,
      ),
    );
  }
}
