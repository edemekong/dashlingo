import 'package:dashlingo/components/base_state.dart';
import 'package:dashlingo/models/user.dart';
import 'package:dashlingo/repositories/user_repository.dart';

class AuthState extends BaseState {
  final UserRepository userRepository = UserRepository.instance;
  User? currentUser;

  AuthState() {
    userRepository.userNotifier.addListener(_listenToCurrentUser);
  }

  @override
  void dispose() {
    userRepository.userNotifier.removeListener(_listenToCurrentUser);
    super.dispose();
  }

  void _listenToCurrentUser() {
    currentUser = userRepository.userNotifier.value;
    notifyListeners();
  }

  void logOut() async {
    final signOut = await userRepository.signOut();
    if (signOut.isRight) {}
  }
}
