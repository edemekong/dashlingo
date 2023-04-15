import 'package:dashlingo/UI/components/base_state.dart';
import 'package:dashlingo/data/models/user.dart';
import 'package:dashlingo/data/repositories/user_repository.dart';

import '../../utils/logs.dart';

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

  void googleSignIn() {
    final user = User(
      uid: '',
      name: '',
      handle: '',
      email: '',
      profileImageUrl: '',
      badges: const [],
      preference: const {
        'interest': {
          'language': 'dart',
          'level': 'beginner',
        },
      },
      createdAt: DateTime.now().millisecondsSinceEpoch,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
      disabled: false,
      isTest: false,
      settings: const {
        'pushNotifications': true,
        'emailNotifications': true,
      },
      pointsData: const {},
    );

    userRepository.siginWithGoogle(user).then((value) {
      if (value.isRight) {
        dashPrint(value.right);
      } else {
        dashPrint(value.left);
      }
    });
  }
}
