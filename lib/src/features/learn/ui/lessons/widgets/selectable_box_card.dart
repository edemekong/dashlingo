// import 'package:dashlingo/src/components/bounce_animation.dart';
// import 'package:dashlingo/src/components/display_image.dart';
// import 'package:dashlingo/src/components/texts.dart';
// import 'package:dashlingo/src/constants/images_path.dart';
// import 'package:dashlingo/UI/screens/lessons/widgets/answer_card.dart';
// import 'package:dashlingo/src/theme/spaces.dart';
// import 'package:flutter/material.dart';

// class SelectableBoxCard extends StatelessWidget {
//   final String title;
//   final String subtitle;

//   final void Function() onTap;
//   final QuizState state;
//   const SelectableBoxCard({
//     Key? key,
//     this.state = QuizState.selected,
//     required this.title,
//     required this.subtitle,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final selected = QuizState.selected == state;
//     return BounceAnimation(
//       onTap: () {},
//       child: Container(
//         padding: const EdgeInsets.all(AppSpaces.elementSpacing),
//         decoration: BoxDecoration(
//           borderRadius: AppSpaces.defaultBorderRadius,
//           color: Theme.of(context).cardColor.withOpacity(selected ? .9 : .2),
//           border: Border.all(
//             width: 1.6,
//             color: Theme.of(context).dividerColor,
//           ),
//         ),
//         child: Row(
//           children: [
//             const DisplayImage(url: ImagePaths.dash1, width: 60, height: 60),
//             const SizedBox(width: AppSpaces.elementSpacing * 0.5),
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   DashTexts.subHeadingSmall(
//                     title,
//                     context,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   const SizedBox(height: AppSpaces.elementSpacing * 0.25),
//                   DashTexts.bodyText(
//                     subtitle,
//                     context,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(width: AppSpaces.elementSpacing * 0.5),
//             Icon(
//               Icons.arrow_forward_ios_rounded,
//               color: Theme.of(context).dividerColor,
//               size: 18,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
