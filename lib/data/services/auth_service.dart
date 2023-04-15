import 'package:dashlingo/data/services/crashlytics_service.dart';
import 'package:dashlingo/utils/logs.dart';
import 'package:dashlingo/utils/results.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService implements SocialAuth {
  AuthService._();

  static AuthService? _instance;

  static AuthService get instance {
    _instance ??= AuthService._();
    return _instance!;
  }

  final _auth = FirebaseAuth.instance;

  User? get firebaseCurrentUser => FirebaseAuth.instance.currentUser;

  @override
  GoogleAuthProvider googleProvider = GoogleAuthProvider();

  @override
  Future<Either<ErrorHandler, User?>> googleSignIn() async {
    try {
      final userCredential = await signInUserWithGoogleCredential(googleProvider);
      if (userCredential.isRight) {
        final authResult = userCredential.right;

        // if (authResult != null && authResult.additionalUserInfo?.isNewUser == true) {
        //   authResult.user?.delete();
        //   return const Left(ErrorHandler("You're not an admin"));
        // }
        final user = authResult?.user;
        return Right(user);
      } else {
        return const Left(ErrorHandler('Failed to sigin with google'));
      }
    } on FirebaseAuthException catch (e) {
      CrashlyticsService.instance.logError(e);
      return Left(ErrorHandler(e.message ?? '', code: e.code));
    }
  }

  Future<Either<ErrorHandler, UserCredential?>> signInUserWithGoogleCredential(GoogleAuthProvider googleAuth) async {
    try {
      // Create a new credential
      if (kIsWeb) {
        googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
        googleProvider.addScope('email');
        googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

        final credential = await _auth.signInWithPopup(googleAuth);
        return Right(credential);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        final userCredential = await _auth.signInWithCredential(credential);
        return Right(userCredential);
      }
    } on FirebaseAuthException catch (e) {
      dashPrint(e);
      CrashlyticsService.instance.logError(e);
      return Left(ErrorHandler(e.message ?? '', code: e.code));
    }
  }

  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }

  Future<Either<ErrorHandler, bool>> signOut() async {
    try {
      await _auth.signOut();
      await GoogleSignIn().signOut();

      return const Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(ErrorHandler(e.message ?? '', code: e.code));
    }
  }
}

abstract class SocialAuth {
  late GoogleAuthProvider googleProvider;
  Future<Either<ErrorHandler, User?>> googleSignIn();
}
