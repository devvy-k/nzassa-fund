import 'dart:developer' as console;

import 'package:crowfunding_project/core/data/datasources/projects_remote_datasource.dart';
import 'package:crowfunding_project/core/data/models/project_model.dart';
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

  Future<void> createProject(ProjectModel project) async {
    try {
      await _remote.createProject(project);
    } catch (e) {
      console.log('[ProjectRepositoryImpl] Error creating project: $e');
      rethrow;
    }
  }
}

