import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final loadingService = locate<UIService>();

    return ValueListenableBuilder<String?>(
      valueListenable: ValueNotifier(''),
      builder: (context, loadingText, _) {
        if (loadingText == null) return const SizedBox();
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).colorScheme.background.withOpacity(.5),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
