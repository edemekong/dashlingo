enum AppRoute {
  authentication,
  learn,
  lesson,
  leaderboard,
  learnDart,
  learnFlutter,
  profile,
  accountSetup,
}

extension AppRouteExtension on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.authentication:
        return '/authentication';
      case AppRoute.learn:
        return '/learn';
      case AppRoute.lesson:
        return '/learn/lesson';
      case AppRoute.leaderboard:
        return '/leaderboard';
      case AppRoute.learnDart:
        return '/learn/dart';
      case AppRoute.learnFlutter:
        return '/learn/flutter';
      case AppRoute.accountSetup:
        return '/account-setup';
      case AppRoute.profile:
        return '/my-profile';
      default:
        return '/';
    }
  }
}

// const String lessonPath = "$learnPath/lesson";
// const String learnPath = "/learn";
// const String leaderboard = "/leaderboard";
// const String dartLearnPath = "$learnPath/dart";
// const String flutterLearnPath = "$learnPath/flutter";
// const String profilePath = "/profile";

List<String> tabPaths = [
  AppRoute.learn.path,
  AppRoute.leaderboard.path,
  AppRoute.profile.path,
];
