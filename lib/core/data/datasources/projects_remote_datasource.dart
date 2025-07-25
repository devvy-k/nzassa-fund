import 'dart:developer' as console;

import 'package:crowfunding_project/core/data/models/comment_model.dart';
import 'package:crowfunding_project/core/data/models/user_profile.dart';
import 'package:crowfunding_project/services/firestrore_service.dart';
import 'package:crowfunding_project/core/data/models/project_model.dart';

class ProjectsRemoteDatasource {
  final FirestroreService firestoreService;

  ProjectsRemoteDatasource(this.firestoreService);

  Stream<List<ProjectModel>> getProjects() {
    return firestoreService.streamProjects();
  }

  Future<void> createProject(ProjectModel project) async {
    // Add media after creation later
    try {
      await firestoreService.createProject(project);
    } catch (e) {
      console.log('[ProjectsRemoteDatasource] Error creating project: $e');
      rethrow;
    }
  }

  Future<void> toggleLikeProject(String projectId, String userId) async {
    try {
      await firestoreService.toggleLikeProject(projectId, userId);
    } catch (e) {
      console.log('[ProjectsRemoteDatasource] Error toggling like: $e');
      rethrow;
    }
  }

  Future<void> addComment({
    required String projectId,
    required String content,
    required UserProfile user,
    String? parentCommentId,
  }) async {
      try {
        await firestoreService.addComment(
          projectId: projectId,
          content: content,
          user: user,
          parentCommentId: parentCommentId,
        );
      } catch (e) {
        console.log('[ProjectsRemoteDatasource] Error adding comment: $e');
        rethrow;
      }
  }

  Stream<List<CommentModel>> getComments(String projectId, {String? parentCommentId}) {
    try {
      return firestoreService.streamComments(projectId, parentCommentId: parentCommentId);
    } catch (e) {
      console.log('[ProjectsRemoteDatasource] Error fetching comments: $e');
      throw Exception('Failed to fetch comments: $e');
    }
  }

  Future<void> deleteComment(String projectId, String commentId) async {
    try {
      await firestoreService.deleteComment(projectId, commentId);
    } catch (e) {
      console.log('[ProjectsRemoteDatasource] Error deleting comment: $e');
      throw Exception('Failed to delete comment: $e');
    }
  }
}
