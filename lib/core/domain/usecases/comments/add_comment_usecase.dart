import 'dart:developer' as console;

import 'package:crowfunding_project/core/data/models/user_profile.dart';
import 'package:crowfunding_project/core/domain/repositories/project_repository.dart';

class AddCommentUsecase {
  final ProjectRepository _projectRepository;

  AddCommentUsecase(this._projectRepository);

  Future<void> call({
    required String projectId,
    required String content,
    required UserProfile user,
    String? parentCommentId,
  }) async {
    try {
      await _projectRepository.addComment(
        projectId: projectId,
        content: content,
        user: user,
        parentCommentId: parentCommentId,
      );
    } catch (e) {
      console.log('Error adding comment: $e');
      rethrow;
    }
  }
}