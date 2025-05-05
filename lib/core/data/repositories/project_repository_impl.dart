import 'dart:developer' as console;

import 'package:crowfunding_project/core/data/datasources/projects_remote_datasource.dart';
import 'package:crowfunding_project/core/data/models/project_model.dart';
import 'package:crowfunding_project/core/domain/repositories/project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectsRemoteDatasource _projectsRemoteDatasource;

  ProjectRepositoryImpl(this._projectsRemoteDatasource);

  @override
  Future<List<ProjectModel>> getProjects() async {
    try {
      final List<ProjectModel> projects =
          await _projectsRemoteDatasource.getProjects();
      console.log('[Repository] Projects length : ${projects.length}');
      return projects;
    } catch (e) {
      throw Exception('Failed to load projects: $e');
    }
  }
}
