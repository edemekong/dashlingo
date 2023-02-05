import 'package:dashlingo/components/hide_widget.dart';
import 'package:dashlingo/screens/overview/widgets/appbar.dart';
import 'package:dashlingo/screens/overview/widgets/sizedbar.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../components/bottom_navigation_bar.dart';
import '../../components/loading_overley.dart';
import '../../components/scaffold.dart';

class OverviewView extends StatelessWidget {
  final Widget body;
  const OverviewView({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    final appPadding = MediaQuery.of(context).padding;
    return Material(
      child: Stack(
        children: [
          Scaffold(
            body: Padding(
              padding: EdgeInsets.only(top: appPadding.top),
              child: ResponsiveBuilder(
                builder: (context, info) {
                  return Column(
                    children: [
                      HideWidget(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            DashAppbar(info: info),
                            const Divider(thickness: 1.5, height: 0),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            if (!info.isMobile) ...[
                              HideWidget(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    DashSizedbar(info: info),
                                    Container(
                                      width: 1.5,
                                      height: MediaQuery.of(context).size.height,
                                      color: Theme.of(context).dividerColor,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            Expanded(
                              child: body,
                            ),
                          ],
                        ),
                      ),
                      if (info.isMobile) ...[
                        const Divider(thickness: 1.5, height: 0),
                        const AppBottomNavigationBar(currentIndex: 0),
                      ],
                    ],
                  );
                },
              ),
            ),
          ),
          const LoadingOverlay(),
        ],
      ),
    );
  }
}
