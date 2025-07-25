class Comment {
  final String id;
  final String content;
  final String? authorId;
  final String authorName;
  final String authorAvatar;
  final DateTime createdAt;
  final List<String>? likes;
  final String? parentCommentId;

  Comment({
    required this.id,
    required this.content,
    this.authorId,
    required this.authorName,
    required this.authorAvatar,
    required this.createdAt,
    this.likes,
    this.parentCommentId,
  });
}
