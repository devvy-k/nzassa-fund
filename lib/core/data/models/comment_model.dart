import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crowfunding_project/core/domain/entities/comment.dart';

class CommentModel extends Comment {
  CommentModel({
    required super.id,
    required super.content,
    required super.authorId,
    required super.authorName,
    required super.authorAvatar,
    required super.createdAt,
    super.likes,
    super.parentCommentId,
  });

  factory CommentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final timestamp = data['createdAt'] as Timestamp;

    return CommentModel(
      id: doc.id,
      content: data['content'] ?? '',
      authorId: data['authorId'] ?? '',
      authorName: data['authorName'] ?? '',
      authorAvatar: data['authorAvatar'] ?? '',
      createdAt: timestamp.toDate(),
      likes: List<String>.from(data['likes'] ?? []),
      parentCommentId: data['parentCommentId'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'authorId': authorId,
      'authorName': authorName,
      'authorAvatar': authorAvatar,
      'createdAt': createdAt.toIso8601String(),
      'likes': likes,
      'parentCommentId': parentCommentId,
    };
  }

  bool get isReply => parentCommentId != null;
}
