import 'package:crowfunding_project/domain/entities/author.dart';

class Post {
  final String id;
  final String? content;
  final String? summary;
  final Author author;
  final List<String>? images;
  final DateTime createdAt;
  final List<String>? likes;
  final List<String>? comments;

  const Post({
    required this.id,
    required this.content,
    required this.summary,
    required this.author,
    required this.images,
    required this.createdAt,
    required this.likes,
    required this.comments,
  });
}
