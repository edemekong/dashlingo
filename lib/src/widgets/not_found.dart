import 'package:dashlingo/src/widgets/texts.dart';
import 'package:dashlingo/src/theme/spaces.dart';
import 'package:flutter/material.dart';
import 'scaffold.dart';

enum ErrorType {
  notFound,
  serverError,
  unknownError,
}

class ErrorScreen extends StatelessWidget {
  final ErrorType type;
  final String? message;

  const ErrorScreen({Key? key, required this.type, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DashTexts.headingBig("404", context),
            DashTexts.headingMedium(message ?? "Page Not Found", context),
            const SizedBox(height: AppSpaces.cardPadding * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                /// TODO: button goes here
              ],
            )
          ],
        ),
      ),
    );
  }
}
