import 'dart:developer' as console;

import 'package:crowfunding_project/core/domain/repositories/project_repository.dart';

class DeleteCommentUsecase {
  final ProjectRepository _projectRepository;

  DeleteCommentUsecase(this._projectRepository);

  Future<void> call(String projectId, String commentId) async {
    try {
      await _projectRepository.deleteComment(projectId, commentId);
    } catch (e) {
      console.log('Error deleting comment: $e');
      rethrow;
    }
  }
}