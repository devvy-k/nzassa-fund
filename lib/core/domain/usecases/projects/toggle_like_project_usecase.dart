import 'package:crowfunding_project/core/domain/repositories/project_repository.dart';

class ToggleLikeProjectUsecase {
  final ProjectRepository _projectRepository;

  ToggleLikeProjectUsecase(this._projectRepository);

  Future<void> call(String projectId, String userId) async {
    if (projectId.isEmpty || userId.isEmpty) {
      throw Exception('Project ID and User ID cannot be empty');
    }
    await _projectRepository.toggleLikeProject(projectId, userId);
  }
}
