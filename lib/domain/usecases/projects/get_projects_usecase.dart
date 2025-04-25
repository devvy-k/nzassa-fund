import 'package:crowfunding_project/data/models/project_model.dart';
import 'package:crowfunding_project/domain/repositories/project_repository.dart';

class GetProjectsUsecase {
  final ProjectRepository _projectRepository;

  GetProjectsUsecase(this._projectRepository);
  Future<List<ProjectModel>> call() => _projectRepository.getProjects();
}
