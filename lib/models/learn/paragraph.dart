import 'dart:convert';

import 'package:flutter/foundation.dart';

enum ParagraphType {
  text,
  image,
  video,
  code,
  output,
  seperator,
  dartpad,
  fillInBlanks,
  fillInMultipleBlanks,
  fileUpload
}

class Paragraph {
  final String id;
  final int index;
  final String? title;
  final String content;
  final double? aspectRatio;
  final String? caption;
  final List<String> fill;

  /// text, image, video, code, seperator
  final String type;

  const Paragraph({
    required this.id,
    required this.index,
    this.title,
    required this.content,
    this.aspectRatio,
    this.caption,
    this.fill = const [],
    required this.type,
  });

  Paragraph copyWith({
    String? id,
    int? index,
    String? title,
    String? content,
    double? aspectRatio,
    String? caption,
    List<String>? fill,
    String? type,
  }) {
    return Paragraph(
      id: id ?? this.id,
      index: index ?? this.index,
      title: title ?? this.title,
      content: content ?? this.content,
      aspectRatio: aspectRatio ?? this.aspectRatio,
      caption: caption ?? this.caption,
      fill: fill ?? this.fill,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'index': index,
      'title': title,
      'content': content,
      'aspectRatio': aspectRatio,
      'caption': caption,
      'fill': fill,
      'type': type,
    };
  }

  factory Paragraph.fromMap(Map<String, dynamic> map) {
    return Paragraph(
      id: map['id'] ?? '',
      index: map['index']?.toInt() ?? 0,
      title: map['title'],
      content: map['content'] ?? '',
      aspectRatio: map['aspectRatio']?.toDouble(),
      caption: map['caption'],
      fill: List<String>.from(map['fill']),
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Paragraph.fromJson(String source) => Paragraph.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Paragraph(id: $id, index: $index, title: $title, content: $content, aspectRatio: $aspectRatio, caption: $caption, fill: $fill, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Paragraph &&
        other.id == id &&
        other.index == index &&
        other.title == title &&
        other.content == content &&
        other.aspectRatio == aspectRatio &&
        other.caption == caption &&
        listEquals(other.fill, fill) &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        index.hashCode ^
        title.hashCode ^
        content.hashCode ^
        aspectRatio.hashCode ^
        caption.hashCode ^
        fill.hashCode ^
        type.hashCode;
  }
}
