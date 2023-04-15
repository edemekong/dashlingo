import 'package:dashlingo/data/services/navigation_service.dart';
import 'package:dashlingo/utils/logs.dart';
import 'package:go_router/go_router.dart';

import '../../UI/components/base_state.dart';
import '../../constants/paths.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';
import '../services/get_it.dart';

class UserState extends BaseState {
  final _userRepository = locate<UserRepository>();
  final navigationService = locate<NavigationService>();

  User? currentUser;

  bool _launchSetUp = true;

  UserState() {
    _userRepository.userNotifier.addListener(_listenToCurrentUser);
  }

  @override
  void dispose() {
    super.dispose();
    _userRepository.userNotifier.removeListener(_listenToCurrentUser);
  }

  // run once when the current user is available
  void _appStartUserAvailable(User user) async {
    dashPrint("APP START: USER AVAILABLE");

    if (!user.accountIsSetup) {
      final context = navigationService.navigatorKey.currentContext!;
      context.pushNamed(AppRoute.accountSetup.name);
    }
  }

  void _listenToCurrentUser() {
    currentUser = _userRepository.userNotifier.value;
    notify();

    if (currentUser == null) _launchSetUp = true;
    if (currentUser != null && _launchSetUp) {
      _launchSetUp = false;
      _appStartUserAvailable(currentUser!);
    }
  }
}
