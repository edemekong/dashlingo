import 'dart:convert';
import 'package:flutter/foundation.dart';

@immutable
class User {
  final String uid;
  final String name;
  final String handle;
  final String email;
  final String profileImageUrl;
  final List<String> badges;
  final int createdAt;
  final int updatedAt;
  final bool disabled;
  final bool isTest;
  final Map<String, dynamic> settings;
  final Map<String, dynamic> pointsData;

  const User({
    required this.uid,
    required this.name,
    required this.handle,
    required this.email,
    required this.profileImageUrl,
    required this.badges,
    required this.createdAt,
    required this.updatedAt,
    required this.disabled,
    required this.isTest,
    required this.settings,
    required this.pointsData,
  });

  User copyWith({
    String? uid,
    String? name,
    String? handle,
    String? email,
    String? profileImageUrl,
    List<String>? badges,
    int? createdAt,
    int? updatedAt,
    bool? disabled,
    bool? isTest,
    Map<String, dynamic>? settings,
    Map<String, dynamic>? pointsData,
  }) {
    return User(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      handle: handle ?? this.handle,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      badges: badges ?? this.badges,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      disabled: disabled ?? this.disabled,
      isTest: isTest ?? this.isTest,
      settings: settings ?? this.settings,
      pointsData: pointsData ?? this.pointsData,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'handle': handle,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'badges': badges,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'disabled': disabled,
      'isTest': isTest,
      'settings': settings,
      'pointsData': pointsData,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      handle: map['handle'] ?? '',
      email: map['email'] ?? '',
      profileImageUrl: map['profileImageUrl'] ?? '',
      badges: List<String>.from(map['badges'] ?? const []),
      createdAt: map['createdAt'] ?? 0,
      updatedAt: map['updatedAt'] ?? 0,
      disabled: map['disabled'] ?? false,
      isTest: map['isTest'] ?? false,
      settings: Map<String, dynamic>.from(map['settings'] ?? const {}),
      pointsData: Map<String, dynamic>.from(map['pointsData'] ?? const {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(uid: $uid, name: $name, handle: $handle, email: $email, profileImageUrl: $profileImageUrl, badges: $badges, createdAt: $createdAt, updatedAt: $updatedAt, disabled: $disabled, isTest: $isTest, settings: $settings, pointsData: $pointsData)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.uid == uid &&
        other.name == name &&
        other.handle == handle &&
        other.email == email &&
        other.profileImageUrl == profileImageUrl &&
        listEquals(other.badges, badges) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.disabled == disabled &&
        other.isTest == isTest &&
        mapEquals(other.settings, settings) &&
        mapEquals(other.pointsData, pointsData);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        handle.hashCode ^
        email.hashCode ^
        profileImageUrl.hashCode ^
        badges.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        disabled.hashCode ^
        isTest.hashCode ^
        settings.hashCode ^
        pointsData.hashCode;
  }
}
