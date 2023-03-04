import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashlingo/models/user.dart';
import 'package:dashlingo/services/auth_service.dart';
import 'package:dashlingo/services/crashlytics_service.dart';
import 'package:dashlingo/services/get_it.dart';
import 'package:dashlingo/utils/logs.dart';
import 'package:dashlingo/utils/results.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';

class UserRepository {
  static UserRepository instance = locate<UserRepository>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _auth = AuthService.instance;

  final ValueNotifier<User?> userNotifier = ValueNotifier<User?>(null);
  StreamSubscription? _userStreamSubscription, _authSubscription;

  UserRepository() {
    listenToAuthChanges();
  }

  Future<Either<ErrorHandler, SuccessHandler<User>>> siginWithGoogle() async {
    try {
      final googleUser = await _auth.googleSignIn();
      if (googleUser.isRight) {
        final firebaseUser = googleUser.right;
        if (firebaseUser == null) return const Left(ErrorHandler('Failed to get user'));
        final userSnapshot = await _firestore.collection('users').doc(firebaseUser.uid).get();

        if (userSnapshot.exists) {
          final getUser = await getCurrentUser(firebaseUser.uid);
          if (getUser.isRight && getUser.right != null) {
            return Right(
              SuccessHandler<User>(getUser.right!, "Successfully Login a User From Google Accout"),
            );
          } else {
            return const Left(ErrorHandler("Failed to get user"));
          }
        } else {
          User user = User(
            uid: firebaseUser.uid,
            name: firebaseUser.displayName ?? '',
            handle: (firebaseUser.displayName ?? '').toLowerCase().replaceAll(' ', ''),
            email: firebaseUser.email ?? '',
            profileImageUrl: firebaseUser.photoURL ?? '',
            badges: const [],
            createdAt: DateTime.now().millisecondsSinceEpoch,
            updatedAt: DateTime.now().millisecondsSinceEpoch,
            disabled: false,
            isTest: false,
            settings: const {},
            pointsData: {
              "points": 20,
              "updatedAt": DateTime.now().millisecondsSinceEpoch,
            },
          );

          await _firestore.collection('users').doc(firebaseUser.uid).set(user.toMap());
          await getCurrentUser(firebaseUser.uid);

          return Right(
            SuccessHandler<User>(user, "Successfully Login a User From Google Accout"),
          );
        }
      } else {
        return const Left(ErrorHandler('An Error Occured...'));
      }
    } catch (e) {
      dashPrint(e);
      return Left(ErrorHandler(e.toString()));
    }
  }

  Future<void> listenToAuthChanges() async {
    try {
      _authSubscription?.cancel();
      _authSubscription = _auth.authStateChanges().listen((firebaseUser) async {
        if (firebaseUser != null) {
          await getCurrentUser(firebaseUser.uid);

          dashPrint("Current user UID -> ${firebaseUser.uid}");
          dashPrint("Current email -> ${firebaseUser.email}");
        } else {
          dashPrint("No Current User");
        }
      });
    } catch (e) {
      dashPrint(e);
    }
  }

  Future<Either<ErrorHandler, User?>> getCurrentUser(String uid) async {
    try {
      final snapshot = await _firestore.collection('users').doc(uid).get();
      if (snapshot.exists) {
        userNotifier.value = User.fromMap(snapshot.data() as Map<String, dynamic>);
        listenToCurrentUser(uid);
      }

      return Right(userNotifier.value);
    } on FirebaseException catch (e) {
      CrashlyticsService.instance.logError(e);
      return Left(ErrorHandler(e.message ?? ''));
    }
  }

  Future<Either<ErrorHandler, User?>> listenToCurrentUser(String uid) async {
    try {
      _userStreamSubscription?.cancel();
      _userStreamSubscription = null;

      _userStreamSubscription = _firestore.collection('users').doc(uid).snapshots().listen((snapshot) {
        if (snapshot.exists) {
          userNotifier.value = User.fromMap(snapshot.data() as Map<String, dynamic>);
        }
      });

      return Right(userNotifier.value);
    } on FirebaseException catch (e) {
      CrashlyticsService.instance.logError(e);
      return Left(ErrorHandler(e.message ?? ''));
    }
  }

  Future<Either<ErrorHandler, bool>> signOut() async {
    try {
      await _auth.signOut();
      _clearListeners();

      userNotifier.value = null;
      return const Right(true);
    } on FirebaseException catch (e) {
      CrashlyticsService.instance.logError(e);
      return Left(ErrorHandler(e.message ?? ''));
    }
  }

  void _clearListeners() {
    _authSubscription?.cancel();
    _userStreamSubscription?.cancel();

    _authSubscription = null;
    _userStreamSubscription = null;
  }
}
