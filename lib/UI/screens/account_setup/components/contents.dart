import 'package:dashlingo/UI/screens/account_setup/account_setup_state.dart';

enum UserLevel { beginner, junior, intermediate, senior }

enum UserLanguage { flutter, dart, flutterDart }

enum UserPurpose { curious, fun, learning }

class UserInterest {
  final String id;
  final String title;
  final String description;
  final AccountSetupPages type;

  const UserInterest({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
  });
}

List<UserInterest> purposes = [
  UserInterest(
    id: UserPurpose.curious.name,
    title: 'Just Curious',
    description: 'I am just curious to try dashlingo!',
    type: AccountSetupPages.purpose,
  ),
  UserInterest(
    id: UserPurpose.fun.name,
    title: 'Fun Playing',
    description: 'I want to have fun with dash.',
    type: AccountSetupPages.purpose,
  ),
  UserInterest(
    id: UserPurpose.learning.name,
    title: 'Serious Learner',
    description: 'I want to learn',
    type: AccountSetupPages.purpose,
  ),
];

List<UserInterest> levels = [
  UserInterest(
    id: UserLevel.beginner.name,
    title: 'Beginner',
    description: 'I am new',
    type: AccountSetupPages.level,
  ),
  UserInterest(
    id: UserLevel.junior.name,
    title: 'Junior',
    description: 'I am already had prior knowledge on dart basics',
    type: AccountSetupPages.level,
  ),
  UserInterest(
    id: UserLevel.intermediate.name,
    title: 'Intermdiate',
    description: 'I am 80% flutter & dart developer',
    type: AccountSetupPages.level,
  ),
  UserInterest(
    id: UserLevel.senior.name,
    title: 'Senior',
    description: '🙂',
    type: AccountSetupPages.level,
  ),
];

List<UserInterest> languages = [
  UserInterest(
    id: UserLanguage.dart.name,
    title: 'Dart',
    description: 'The dart language',
    type: AccountSetupPages.language,
  ),
  UserInterest(
    id: UserLanguage.flutter.name,
    title: 'Flutter',
    description: 'Flutter Framework',
    type: AccountSetupPages.language,
  ),
  UserInterest(
    id: UserLanguage.flutterDart.name,
    title: 'Flutter & Dart',
    description: 'Flutter & Dart',
    type: AccountSetupPages.language,
  ),
];
