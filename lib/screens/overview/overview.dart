import 'package:flutterfairy/screens/overview/widgets/appbar.dart';
import 'package:flutterfairy/screens/overview/widgets/sizedbar.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
            drawer: const Drawer(
              child: EdSizedbar(
                drawer: true,
              ),
            ),
            body: ResponsiveBuilder(
              builder: (context, info) {
                return Row(
                  children: [
                    if (!info.isMobile && !info.isTablet) ...[
                      const EdSizedbar(drawer: false),
                      Container(
                        width: 1.5,
                        height: MediaQuery.of(context).size.height,
                        color: Theme.of(context).dividerColor,
                      ),
                    ],
                    const NavigationBody(),
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
          initialRoute: homePath,
          observers: [RouteObservers()],
          key: navigationService.navigatorKey,
          onGenerateRoute: navigationService.onGeneratedRoute,
        ),
      ),
    );
  }
}
