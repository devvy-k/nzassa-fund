import 'dart:developer' as console;

import 'package:crowfunding_project/core/data/datasources/projects_remote_datasource.dart';
import 'package:crowfunding_project/core/data/models/comment_model.dart';
import 'package:crowfunding_project/core/data/models/project_model.dart';
import 'package:crowfunding_project/core/data/models/user_profile.dart';
import 'package:crowfunding_project/core/domain/repositories/project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectsRemoteDatasource _remote;

  ProjectRepositoryImpl(this._remote);

  @override
  Stream<List<ProjectModel>> getProjects({List<String>? preferredCategories}) {
    return _remote.getProjects().map((projects) {
      if (preferredCategories == null || preferredCategories.isEmpty) {
        return projects;
      }

      final prioritized = <ProjectModel>[];
      final suggestions = <ProjectModel>[];

      for (final project in projects) {
        if (preferredCategories.contains(project.category)) {
          prioritized.add(project);
        } else {
          suggestions.add(project);
        }
      }

      return [...prioritized, ...suggestions];
    });
  }

  @override
  Future<void> createProject(ProjectModel project) async {
    try {
      await _remote.createProject(project);
    } catch (e) {
      console.log('[ProjectRepositoryImpl] Error creating project: $e');
      rethrow;
    }
  }

  @override
  Future<void> toggleLikeProject(String projectId, String userId) async {
    try {
      await _remote.toggleLikeProject(projectId, userId);
    } catch (e) {
      console.log('[ProjectRepositoryImpl] Error toggling like: $e');
      rethrow;
    }
  }

  @override
  Future<void> addComment({
    required String projectId,
    required String content,
    required UserProfile user,
    String? parentCommentId,
  }) async {
    try {
      await _remote.addComment(
        projectId: projectId,
        content: content,
        user: user,
        parentCommentId: parentCommentId,
      );
    } catch (e) {
      console.log('[ProjectRepositoryImpl] Error adding comment: $e');
      rethrow;
    }
  }

  @override
  Stream<List<CommentModel>> getComments(String projectId, {String? parentCommentId}) {
    try {
      return _remote.getComments(projectId, parentCommentId: parentCommentId);
    } catch (e) {
      console.log('[ProjectRepositoryImpl] Error fetching comments: $e');
      throw Exception('Failed to fetch comments: $e');
    }
  }

  @override
  Future<void> deleteComment(String projectId, String commentId) async {
    try {
      await _remote.deleteComment(projectId, commentId);
    } catch (e) {
      console.log('[ProjectRepositoryImpl] Error deleting comment: $e');
      throw Exception('Failed to delete comment: $e');
    }
  }
}

