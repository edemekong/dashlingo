import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'paragraph.dart';

class Tutorial {
  final String id;
  final String title;
  final String description;
  final List<Paragraph> paragraphs;
  final Map<String, dynamic> author;
  final int createdAt;
  final int updatedAt;
  Tutorial({
    required this.id,
    required this.title,
    required this.description,
    required this.paragraphs,
    required this.author,
    required this.createdAt,
    required this.updatedAt,
  });

  Tutorial copyWith({
    String? id,
    String? title,
    String? description,
    List<Paragraph>? paragraphs,
    Map<String, dynamic>? author,
    int? createdAt,
    int? updatedAt,
  }) {
    return Tutorial(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      paragraphs: paragraphs ?? this.paragraphs,
      author: author ?? this.author,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'paragraphs': paragraphs.map((x) => x.toMap()).toList(),
      'author': author,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Tutorial.fromMap(Map<String, dynamic> map) {
    return Tutorial(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      paragraphs: List<Paragraph>.from(map['paragraphs']?.map((x) => Paragraph.fromMap(x))),
      author: Map<String, dynamic>.from(map['author']),
      createdAt: map['createdAt']?.toInt() ?? 0,
      updatedAt: map['updatedAt']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tutorial.fromJson(String source) => Tutorial.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Tutorial(id: $id, title: $title, description: $description, paragraphs: $paragraphs, author: $author, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Tutorial &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        listEquals(other.paragraphs, paragraphs) &&
        mapEquals(other.author, author) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        paragraphs.hashCode ^
        author.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
