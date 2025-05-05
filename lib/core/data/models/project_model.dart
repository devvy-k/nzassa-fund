import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crowfunding_project/core/domain/entities/author.dart';
import 'package:crowfunding_project/core/domain/entities/project.dart';
import 'package:flutter/foundation.dart';

class ProjectModel extends Project {
  ProjectModel({
    required super.id,
    required super.content,
    required super.summary,
    required super.author,
    required super.images,
    required super.createdAt,
    required super.likes,
    required super.comments,
  });

  factory ProjectModel.fromJson(
    String id,
    Map<String, dynamic> json,
    Author author,
  ) {
    // Parse date
    DateTime createdAt;
    final dynamic rawDate = json['createdAt'];
    if (rawDate is Timestamp) {
      createdAt = rawDate.toDate();
    } else if (rawDate is String && rawDate.isNotEmpty) {
      try {
        createdAt = DateTime.parse(rawDate);
      } catch (_) {
        createdAt = DateTime.now(); // fallback si parsing échoue
      }
    } else {
      createdAt = DateTime.now(); // fallback si vide
    }

    return ProjectModel(
      id: id.isNotEmpty ? id : UniqueKey().toString(),
      content: json['content'] ?? '',
      summary: json['summary'] ?? '',
      author: author,
      images: List<String>.from(json['images'] ?? []),
      createdAt: createdAt,
      likes: List<String>.from(json['likes'] ?? []),
      comments: List<String>.from(json['comments'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'summary': summary,
      'author': author.id,
      'images': images,
      'createdAt': createdAt.toIso8601String(),
      'likes': likes,
      'comments': comments,
    };
  }
}
