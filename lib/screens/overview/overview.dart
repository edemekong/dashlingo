import 'package:dashlingo/screens/overview/widgets/appbar.dart';
import 'package:dashlingo/screens/overview/widgets/sizedbar.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../components/bottom_navigation_bar.dart';
import '../../components/loading_overley.dart';
import '../../components/scaffold.dart';
import '../../constants/paths.dart';
import '../../services/get_it.dart';
import '../../services/navigation_service.dart';

class OverviewView extends StatelessWidget {
  const OverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          AppScaffold(
            body: ResponsiveBuilder(
              builder: (context, info) {
                return Column(
                  children: [
                    DashAppbar(info: info),
                    const Divider(thickness: 1.5, height: 0),
                    Expanded(
                      child: Row(
                        children: [
                          if (!info.isMobile) ...[
                            DashSizedbar(info: info),
                            Container(
                              width: 1.5,
                              height: MediaQuery.of(context).size.height,
                              color: Theme.of(context).dividerColor,
                            ),
                          ],
                          const NavigationBody(),
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
          const LoadingOverlay(),
        ],
      ),
    );
  }
}

class NavigationBody extends StatelessWidget {
  const NavigationBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationService = locate<NavigationService>();

    return Expanded(
      child: ClipRRect(
        child: Navigator(
          initialRoute: learnPath,
          key: navigationService.navigatorKey,
          onGenerateRoute: navigationService.onGeneratedRoute,
        ),
      ),
    );
  }
}
