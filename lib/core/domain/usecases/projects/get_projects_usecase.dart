import 'package:crowfunding_project/core/data/models/project_model.dart';
import 'package:crowfunding_project/core/domain/repositories/project_repository.dart';

class GetProjectsUsecase {
  final ProjectRepository _projectRepository;

  GetProjectsUsecase(this._projectRepository);
  
  Stream<List<ProjectModel>> call({List<String>? preferredCategories}) {
    return _projectRepository.getProjects(preferredCategories: preferredCategories);
  }
}
