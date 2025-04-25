import 'dart:developer' as console;

import 'package:crowfunding_project/core/services/firestrore_service.dart';
import 'package:crowfunding_project/data/models/project_model.dart';

class ProjectsRemoteDatasource {
  final FirestroreService firestoreService;

  ProjectsRemoteDatasource(this.firestoreService);

  Future<List<ProjectModel>> getProjects() async {
    final projects = await firestoreService.getPosts();
    console.log('[RemoteDatasource] Projects length : ${projects.length}');
    return projects;
  }
}
