import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget? body;
  final Widget? drawer;

  const AppScaffold({super.key, this.body, this.drawer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: body,
      ),
      drawer: drawer,
    );
  }
}
