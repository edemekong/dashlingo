import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:dashlingo/models/learn/lesson.dart';

class DashStep {
  final String id;
  final String title;
  final String description;
  final int createdAt;
  final int updatedAt;
  final int totalLessons;
  final Map<String, dynamic> author;
  final List<Lesson> lessons;
  final String verson;
  final String level;
  final String tutorialId;
  final List<String> dashes;
  final String coverImage;

  const DashStep({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.totalLessons,
    required this.author,
    required this.lessons,
    required this.verson,
    required this.level,
    required this.tutorialId,
    required this.dashes,
    required this.coverImage,
  });

  DashStep copyWith({
    String? id,
    String? title,
    String? description,
    int? createdAt,
    int? updatedAt,
    int? totalLessons,
    Map<String, dynamic>? author,
    List<Lesson>? lessons,
    String? verson,
    String? level,
    String? tutorialId,
    List<String>? dashes,
    String? coverImage,
  }) {
    return DashStep(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      totalLessons: totalLessons ?? this.totalLessons,
      author: author ?? this.author,
      lessons: lessons ?? this.lessons,
      verson: verson ?? this.verson,
      level: level ?? this.level,
      tutorialId: tutorialId ?? this.tutorialId,
      dashes: dashes ?? this.dashes,
      coverImage: coverImage ?? this.coverImage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'totalLessons': totalLessons,
      'author': author,
      'lessons': lessons.map((x) => x.toMap()).toList(),
      'verson': verson,
      'level': level,
      'tutorialId': tutorialId,
      'dashes': dashes,
      'coverImage': coverImage,
    };
  }

  factory DashStep.fromMap(Map<String, dynamic> map) {
    return DashStep(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      createdAt: map['createdAt']?.toInt() ?? 0,
      updatedAt: map['updatedAt']?.toInt() ?? 0,
      totalLessons: map['totalLessons']?.toInt() ?? 0,
      author: Map<String, dynamic>.from(map['author']),
      lessons: List<Lesson>.from(map['lessons']?.map((x) => Lesson.fromMap(x))),
      verson: map['verson'] ?? '',
      level: map['level'] ?? '',
      tutorialId: map['tutorialId'] ?? '',
      dashes: List<String>.from(map['dashes']),
      coverImage: map['coverImage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DashStep.fromJson(String source) => DashStep.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DashStep(id: $id, title: $title, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, totalLessons: $totalLessons, author: $author, lessons: $lessons, verson: $verson, level: $level, tutorialId: $tutorialId, dashes: $dashes, coverImage: $coverImage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DashStep &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.totalLessons == totalLessons &&
        mapEquals(other.author, author) &&
        listEquals(other.lessons, lessons) &&
        other.verson == verson &&
        other.level == level &&
        other.tutorialId == tutorialId &&
        listEquals(other.dashes, dashes) &&
        other.coverImage == coverImage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        totalLessons.hashCode ^
        author.hashCode ^
        lessons.hashCode ^
        verson.hashCode ^
        level.hashCode ^
        tutorialId.hashCode ^
        dashes.hashCode ^
        coverImage.hashCode;
  }
}
