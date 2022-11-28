import 'dart:convert';

import 'package:equatable/equatable.dart';

class Quiz extends Equatable {
  final String lessonId;
  final String quizId;

  /// beginner, intermediate or advance
  final String pathType;
  final String title;
  final int pathLevel;

  ///learn, play, playAndLearn
  final String quizType;
  final String instruction;
  final Map<String, dynamic> intructor;
  final Question question;
  final List<Answer> answers;
  final String correctAnswerId;
  final String clue;
  final int createdAt;
  final int updatedAt;

  const Quiz({
    required this.lessonId,
    required this.quizId,
    required this.pathType,
    required this.title,
    required this.pathLevel,
    required this.quizType,
    required this.instruction,
    required this.intructor,
    required this.question,
    required this.answers,
    required this.correctAnswerId,
    required this.clue,
    required this.createdAt,
    required this.updatedAt,
  });

  Quiz copyWith({
    String? lessonId,
    String? quizId,
    String? pathType,
    String? title,
    int? pathLevel,
    String? quizType,
    String? instruction,
    Map<String, dynamic>? intructor,
    Question? question,
    List<Answer>? answers,
    String? correctAnswerId,
    String? clue,
    int? createdAt,
    int? updatedAt,
  }) {
    return Quiz(
      lessonId: lessonId ?? this.lessonId,
      quizId: quizId ?? this.quizId,
      pathType: pathType ?? this.pathType,
      title: title ?? this.title,
      pathLevel: pathLevel ?? this.pathLevel,
      quizType: quizType ?? this.quizType,
      instruction: instruction ?? this.instruction,
      intructor: intructor ?? this.intructor,
      question: question ?? this.question,
      answers: answers ?? this.answers,
      correctAnswerId: correctAnswerId ?? this.correctAnswerId,
      clue: clue ?? this.clue,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lessonId': lessonId,
      'quizId': quizId,
      'pathType': pathType,
      'title': title,
      'pathLevel': pathLevel,
      'quizType': quizType,
      'instruction': instruction,
      'intructor': intructor,
      'question': question.toMap(),
      'answers': answers.map((x) => x.toMap()).toList(),
      'correctAnswerId': correctAnswerId,
      'clue': clue,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Quiz.fromMap(Map<String, dynamic> map) {
    return Quiz(
      lessonId: map['lessonId'] ?? '',
      quizId: map['quizId'] ?? '',
      pathType: map['pathType'] ?? '',
      title: map['title'] ?? '',
      pathLevel: map['pathLevel']?.toInt() ?? 0,
      quizType: map['quizType'] ?? '',
      instruction: map['instruction'] ?? '',
      intructor: Map<String, dynamic>.from(map['intructor']),
      question: Question.fromMap(map['question']),
      answers: List<Answer>.from(map['answers']?.map((x) => Answer.fromMap(x))),
      correctAnswerId: map['correctAnswerId'] ?? '',
      clue: map['clue'] ?? '',
      createdAt: map['createdAt']?.toInt() ?? 0,
      updatedAt: map['updatedAt']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Quiz.fromJson(String source) => Quiz.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Quiz(lessonId: $lessonId, quizId: $quizId, pathType: $pathType, title: $title, pathLevel: $pathLevel, quizType: $quizType, instruction: $instruction, intructor: $intructor, question: $question, answers: $answers, correctAnswerId: $correctAnswerId, clue: $clue, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  List<Object> get props {
    return [
      lessonId,
      quizId,
      pathType,
      title,
      pathLevel,
      quizType,
      instruction,
      intructor,
      question,
      answers,
      correctAnswerId,
      clue,
      createdAt,
      updatedAt,
    ];
  }
}

enum QuestionType {
  multipleChoice,
  conditional,
  fillInTheBlank,
  fillInMultipleBlank,
  multipleAnswers,
  matching,
  numericalAnswer,
  formular,
  essay,
  fileUpload,
}

class Question extends Equatable {
  final String id;
  final String quizId;

  /// option
  final QuestionType questionType;
  final String content;
  final String linkToLesson;

  const Question({
    required this.id,
    required this.quizId,
    required this.questionType,
    required this.content,
    required this.linkToLesson,
  });

  Question copyWith({
    String? id,
    String? quizId,
    QuestionType? questionType,
    String? content,
    List<Map<String, dynamic>>? fill,
    String? linkToLesson,
  }) {
    return Question(
      id: id ?? this.id,
      quizId: quizId ?? this.quizId,
      questionType: questionType ?? this.questionType,
      content: content ?? this.content,
      linkToLesson: linkToLesson ?? this.linkToLesson,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quizId': quizId,
      'questionType': questionType,
      'content': content,
      'linkToLesson': linkToLesson,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] ?? '',
      quizId: map['quizId'] ?? '',
      questionType: map['questionType'] ?? '',
      content: map['content'] ?? '',
      linkToLesson: map['linkToLesson'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) => Question.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Question(id: $id, quizId: $quizId, questionType: $questionType, content: $content, linkToLesson: $linkToLesson)';
  }

  @override
  List<Object> get props {
    return [
      id,
      quizId,
      questionType,
      content,
      linkToLesson,
    ];
  }
}

class Answer extends Equatable {
  final String id;
  final String quizId;
  final String content;
  final String type;

  const Answer({
    required this.id,
    required this.quizId,
    required this.content,
    required this.type,
  });

  Answer copyWith({
    String? id,
    String? quizId,
    String? content,
    String? type,
    bool? correct,
  }) {
    return Answer(
      id: id ?? this.id,
      quizId: quizId ?? this.quizId,
      content: content ?? this.content,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quizId': quizId,
      'content': content,
      'type': type,
    };
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      id: map['id'] ?? '',
      quizId: map['quizId'] ?? '',
      content: map['content'] ?? '',
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Answer.fromJson(String source) => Answer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Answer(id: $id, quizId: $quizId, content: $content, type: $type, ';
  }

  @override
  List<Object> get props {
    return [
      id,
      quizId,
      content,
      type,
    ];
  }
}
