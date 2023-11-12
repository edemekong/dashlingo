import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:dashlingo/src/features/learn/data/models/learn/paragraph.dart';

class Learn {
  final String lessonId;
  final String learnId;

  final String title;
  final String instruction;

  final List<Paragraph> content;

  final int pathLevel;

  ///learn, play, playAndLearn
  final String type;

  final Map<String, dynamic> intructor;
  final List<Answer> answers;
  final List<String> correctAnswerIds;
  final List<String> clues;
  final int createdAt;
  final int updatedAt;

  const Learn({
    required this.lessonId,
    required this.learnId,
    required this.title,
    required this.instruction,
    required this.content,
    required this.pathLevel,
    required this.type,
    required this.intructor,
    required this.answers,
    required this.correctAnswerIds,
    required this.clues,
    required this.createdAt,
    required this.updatedAt,
  });

  Learn copyWith({
    String? lessonId,
    String? learnId,
    String? title,
    String? instruction,
    List<Paragraph>? content,
    int? pathLevel,
    String? type,
    Map<String, dynamic>? intructor,
    List<Answer>? answers,
    List<String>? correctAnswerIds,
    List<String>? clues,
    int? createdAt,
    int? updatedAt,
  }) {
    return Learn(
      lessonId: lessonId ?? this.lessonId,
      learnId: learnId ?? this.learnId,
      title: title ?? this.title,
      instruction: instruction ?? this.instruction,
      content: content ?? this.content,
      pathLevel: pathLevel ?? this.pathLevel,
      type: type ?? this.type,
      intructor: intructor ?? this.intructor,
      answers: answers ?? this.answers,
      correctAnswerIds: correctAnswerIds ?? this.correctAnswerIds,
      clues: clues ?? this.clues,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lessonId': lessonId,
      'learnId': learnId,
      'title': title,
      'instruction': instruction,
      'content': content.map((x) => x.toMap()).toList(),
      'pathLevel': pathLevel,
      'type': type,
      'intructor': intructor,
      'answers': answers.map((x) => x.toMap()).toList(),
      'correctAnswerId': correctAnswerIds,
      'clues': clues,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Learn.fromMap(Map<String, dynamic> map) {
    return Learn(
      lessonId: map['lessonId'] ?? '',
      learnId: map['learnId'] ?? '',
      title: map['title'] ?? '',
      instruction: map['instruction'] ?? '',
      content: List<Paragraph>.from(map['content']?.map((x) => Paragraph.fromMap(x))),
      pathLevel: map['pathLevel']?.toInt() ?? 0,
      type: map['type'] ?? '',
      intructor: Map<String, dynamic>.from(map['intructor']),
      answers: List<Answer>.from(map['answers']?.map((x) => Answer.fromMap(x))),
      correctAnswerIds: List<String>.from(map['correctAnswerIds']),
      clues: List<String>.from(map['clues']),
      createdAt: map['createdAt']?.toInt() ?? 0,
      updatedAt: map['updatedAt']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Learn.fromJson(String source) => Learn.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Learn(lessonId: $lessonId, learnId: $learnId, title: $title, instruction: $instruction, content: $content, pathLevel: $pathLevel, type: $type, intructor: $intructor, answers: $answers, correctAnswerId: $correctAnswerIds, clues: $clues, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Learn &&
        other.lessonId == lessonId &&
        other.learnId == learnId &&
        other.title == title &&
        other.instruction == instruction &&
        listEquals(other.content, content) &&
        other.pathLevel == pathLevel &&
        other.type == type &&
        mapEquals(other.intructor, intructor) &&
        listEquals(other.answers, answers) &&
        other.correctAnswerIds == correctAnswerIds &&
        listEquals(other.clues, clues) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return lessonId.hashCode ^
        learnId.hashCode ^
        title.hashCode ^
        instruction.hashCode ^
        content.hashCode ^
        pathLevel.hashCode ^
        type.hashCode ^
        intructor.hashCode ^
        answers.hashCode ^
        correctAnswerIds.hashCode ^
        clues.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

class Answer {
  final String id;
  final String learnId;
  final String content;
  final String type;

  const Answer({
    required this.id,
    required this.learnId,
    required this.content,
    required this.type,
  });

  Answer copyWith({
    String? id,
    String? learnId,
    String? content,
    String? type,
    bool? correct,
  }) {
    return Answer(
      id: id ?? this.id,
      learnId: learnId ?? this.learnId,
      content: content ?? this.content,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'learnId': learnId,
      'content': content,
      'type': type,
    };
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      id: map['id'] ?? '',
      learnId: map['learnId'] ?? '',
      content: map['content'] ?? '',
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Answer.fromJson(String source) => Answer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Answer(id: $id, learnId: $learnId, content: $content, type: $type, ';
  }
}
