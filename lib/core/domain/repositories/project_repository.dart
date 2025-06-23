import 'package:crowfunding_project/core/data/models/project_model.dart';

abstract class ProjectRepository {
  Stream<List<ProjectModel>> getProjects({List<String>? preferredCategories});
  Future<void> createProject(ProjectModel project);
}
