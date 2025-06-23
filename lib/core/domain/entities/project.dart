
import 'package:crowfunding_project/core/data/models/author_model.dart';

class Project {
  final String id;
  final String? title;
  final String? content;
  final AuthorModel author;
  final List<String> images;
  final DateTime createdAt;
  final int? totalCollected;
  final int collectGoal;
  final int? likes;
  final List<String>? comments;
  final String? category;
  final List<String>? tags;
  final List<String>? receipts;

  const Project({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.images,
    required this.createdAt,
    required this.totalCollected,
    required this.collectGoal,
    required this.likes,
    required this.comments,
    required this.category,
    required this.tags,
    required this.receipts,
  });
}
