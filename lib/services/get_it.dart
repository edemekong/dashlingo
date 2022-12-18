import 'package:dashlingo/services/navigation_service.dart';
import 'package:dashlingo/utils/logs.dart';
import 'package:get_it/get_it.dart';

import 'ui_service.dart';

class GetItService {
  static final getIt = GetIt.instance;

  static void init() {
    getIt.registerSingleton<NavigationService>(NavigationService());
    getIt.registerSingleton<UIService>(UIService());

    edPrint("Get-it initialized");
  }
}

T locate<T extends Object>() {
  return GetItService.getIt<T>();
}
