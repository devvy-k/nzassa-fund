import 'package:crowfunding_project/core/data/models/project_model.dart';
import 'package:crowfunding_project/core/domain/repositories/project_repository.dart';

class CreateProjectUseCase {
  final ProjectRepository _projectRepository;

  CreateProjectUseCase(this._projectRepository);

  Future<void> call(ProjectModel project) async {
    if (project.content!.isEmpty) {
      throw Exception('Project content cannot be empty');
    }
    await _projectRepository.createProject(project);
  }
}