// import 'package:flutter/material.dart';
// import 'package:dashlingo/src/components/scaffold.dart';
// import 'package:dashlingo/src/components/stepper.dart';
// import 'package:dashlingo/UI/screens/lessons/lesson_state.dart';
// import 'package:dashlingo/src/theme/spaces.dart';
// import 'package:provider/provider.dart';
// import 'package:responsive_builder/responsive_builder.dart';

// import 'learn_play_view.dart';

// class LessonView extends StatelessWidget {
//   const LessonView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final state = context.watch<LessonState>();

//     return AppScaffold(
//       body: ResponsiveBuilder(builder: (context, info) {
//         final width = info.isDesktop ? (info.localWidgetSize.width * 0.75) : null;

//         return Column(
//           children: [
//             const SizedBox(height: AppSpaces.elementSpacing),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: AppSpaces.elementSpacing),
//               child: SizedBox(
//                 width: width,
//                 child: Row(
//                   children: [
//                     IconButton(
//                       padding: EdgeInsets.zero,
//                       icon: const Icon(Icons.close),
//                       tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
//                       onPressed: () {
//                         Navigator.maybePop(context);
//                       },
//                     ),
//                     const SizedBox(width: AppSpaces.elementSpacing),
//                     Expanded(
//                       child: StepperProgressBar(
//                         count: (((state.currentPageIndex + 1) / 3) * 100).toInt(),
//                         width: info.localWidgetSize.width * 0.9,
//                         height: 15,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Expanded(
//               child: PageView(
//                 onPageChanged: state.onPageChanged,
//                 controller: state.pageController,
//                 physics: const NeverScrollableScrollPhysics(),
//                 children: [
//                   for (var i = 0; i < state.playAndLearn.length; i++) ...[
//                     LearnPlayViewWidget(
//                       learn: state.playAndLearn[i],
//                       onNext: state.onNext,
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }

// class LessonViewWidget extends StatelessWidget {
//   const LessonViewWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => LessonState(),
//       child: const LessonView(),
//     );
//   }
// }
