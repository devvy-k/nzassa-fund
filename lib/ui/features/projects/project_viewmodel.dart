import 'dart:developer' as console;

import 'package:crowfunding_project/core/data/models/project_model.dart';
import 'package:crowfunding_project/core/domain/usecases/projects/get_projects_usecase.dart';
import 'package:get/get.dart';

class ProjectsViewmodel extends GetxController {
  final GetProjectsUsecase getProjectsUsecase;
  ProjectsViewmodel(this.getProjectsUsecase);

  // Reactive projects data
  final RxList<ProjectModel> projects = <ProjectModel>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    console.log('[ProjectsViewmodel] onInit');
    fetchProjects();
    super.onInit();
  }

  void fetchProjects() async {
    isLoading.value = true;
    getProjectsUsecase
        .call()
        .then((fetchedProjects) {
          projects.assignAll(fetchedProjects);
          isLoading.value = false;
        })
        .catchError((error) {
          // Handle error
          isLoading.value = false;
        });
  }
}
