import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crowfunding_project/core/data/models/author_model.dart';
import 'package:crowfunding_project/core/data/models/comment_model.dart';
import 'package:crowfunding_project/core/domain/entities/project.dart';

class ProjectModel extends Project {
  ProjectModel({
    required super.id,
    required super.title,
    required super.content,
    required super.author,
    required super.images,
    required super.createdAt,
    required super.totalCollected,
    required super.collectGoal,
    required super.likes,
    required super.comments,
    required super.category,
    required super.tags,
    required super.receipts,
  });

  factory ProjectModel.fromJson(
    String id,
    Map<String, dynamic> json,
    AuthorModel author,
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
      id: id,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      author: author,
      images: List<String>.from(json['images'] ?? []),
      createdAt: createdAt,
      likes: List<String>.from(json['likes'] ?? []),
      totalCollected: json['totalCollected'] ?? 0,
      collectGoal: json['collectGoal'] ?? 0,
      comments: List<CommentModel>.from(json['comments'] ?? []),
      category: json['category'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      receipts: List<String>.from(json['receipts'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'author': author.toJson(),
      'images': images,
      'createdAt': createdAt.toIso8601String(),
      'totalCollected': totalCollected,
      'collectGoal': collectGoal,
      'likes': likes,
      'comments': comments,
      'category': category,
      'tags': tags,
      'receipts': receipts,
    };
  }
}
