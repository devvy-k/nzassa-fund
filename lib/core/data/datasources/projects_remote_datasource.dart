import 'dart:developer' as console;

import 'package:crowfunding_project/services/firestrore_service.dart';
import 'package:crowfunding_project/core/data/models/project_model.dart';

class ProjectsRemoteDatasource {
  final FirestroreService firestoreService;

  ProjectsRemoteDatasource(this.firestoreService);

  Stream<List<ProjectModel>> getProjects() {
    return firestoreService.streamProjects();
  }

  Future<void> createProject(ProjectModel project) async {
    // Add media after creation later
    try {
      await firestoreService.createProject(project);
    } catch (e) {
      console.log('[ProjectsRemoteDatasource] Error creating project: $e');
      rethrow;
    }
  }
}
