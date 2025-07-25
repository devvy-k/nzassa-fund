import 'package:crowfunding_project/core/data/models/comment_model.dart';
import 'package:crowfunding_project/core/data/models/project_model.dart';
import 'package:crowfunding_project/core/data/models/user_profile.dart';

abstract class ProjectRepository {
  Stream<List<ProjectModel>> getProjects({List<String>? preferredCategories});
  Future<void> createProject(ProjectModel project);
  Future<void> toggleLikeProject(String projectId, String userId);
  Future<void> addComment({
    required String projectId,
    required String content,
    required UserProfile user,
    String? parentCommentId,
  });
  Stream<List<CommentModel>> getComments(String projectId, {String? parentCommentId});
  Future<void> deleteComment(String projectId, String commentId);
}
