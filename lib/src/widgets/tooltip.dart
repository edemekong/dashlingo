// import 'package:flutter/material.dart';

// class MedallaToolTipDropdown extends StatefulWidget {
//   final Widget child;
//   final Widget icon;
//   final Color? backgroundColor;
//   final double? width;

//   const MedallaToolTipDropdown(
//       {Key? key, required this.child, required this.icon, color, this.backgroundColor, this.width})
//       : super(key: key);

//   @override
//   State<MedallaToolTipDropdown> createState() => _MedallaToolTipDropdownState();
// }

// class _MedallaToolTipDropdownState extends State<MedallaToolTipDropdown> with TickerProviderStateMixin {
//   final MedallaUIService _uiService = locate<MedallaUIService>();
//   late LabeledGlobalKey key;
//   Offset _offset = Offset.zero;
//   bool isTap = false;

//   AnimationController? _controller;

//   @override
//   void setState(VoidCallback fn) {
//     if (mounted) {
//       super.setState(fn);
//     }
//   }

//   @override
//   void initState() {
//     key = LabeledGlobalKey('sdfdas');
//     _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 150));
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }

//   void getOffsetForOverlay() {
//     RenderBox renderBox = key.currentContext?.findRenderObject() as RenderBox;
//     final offset = renderBox.localToGlobal(Offset.zero);
//     _offset = offset;
//     print("open offset ${_offset.dx}");
//   }

//   OverlayEntry _makeOverlay() {
//     return OverlayEntry(
//       builder: (context) => Stack(
//         children: [
//           GestureDetector(
//             onTap: () {
//               if (mounted) {
//                 _controller?.reverse();
//               }
//               _uiService.unsetOverlay();
//             },
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               color: Colors.transparent,
//             ),
//           ),
//           Positioned(
//             top: _offset.dy + 0,
//             left: _offset.dx - (widget.width ?? 120),
//             child: ScaleTransition(
//               scale: Tween<double>(begin: 0.5, end: 0.9)
//                   .animate(CurvedAnimation(parent: _controller!, curve: Curves.easeOutCubic)),
//               child: ToolTipDropdown(
//                 widget: widget.child,
//                 width: widget.width,
//                 color: widget.backgroundColor ?? Theme.of(context).canvasColor,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(4.0),
//       child: InkWell(
//         key: key,
//         onTap: () {
//           if (!_uiService.hasOverlay) {
//             getOffsetForOverlay();
//             Overlay.of(context)?.insert(_uiService.createOverlay(_makeOverlay()));
//             setState(() {});
//             _controller?.forward();
//             setState(() {
//               isTap = true;
//             });
//           } else {
//             _uiService.unsetOverlay();
//             medallaPrint("already open");
//           }
//         },
//         child: widget.icon,
//       ),
//     );
//   }
// }

// class ToolTipDropdown extends StatelessWidget {
//   final Color? color;

//   final double? width;

//   const ToolTipDropdown({
//     Key? key,
//     required this.widget,
//     this.color,
//     this.width,
//   }) : super(key: key);

//   final Widget widget;

//   @override
//   Widget build(BuildContext context) {
//     final isLight = Theme.of(context).brightness == Brightness.light;
//     return Material(
//       color: Colors.transparent,
//       child: Container(
//         decoration: BoxDecoration(
//           color: isLight ? Theme.of(context).backgroundColor : Theme.of(context).cardColor,
//           borderRadius: AppSpacing.defaultBorderRadiusSmall,
//           border:
//               Border.all(color: Theme.of(context).dividerColor, width: Theme.of(context).dividerTheme.thickness ?? 1.0),
//           boxShadow: [
//             BoxShadow(
//               spreadRadius: 3,
//               blurRadius: 12,
//               color: Theme.of(context).shadowColor,
//               offset: Offset(2, 4),
//             ),
//           ],
//         ),
//         child: widget,
//         padding: const EdgeInsets.symmetric(
//           vertical: AppSpacing.elementSpacing,
//           horizontal: AppSpacing.elementSpacing * 1.5,
//         ),
//       ),
//     );
//   }
// }
