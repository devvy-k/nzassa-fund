import 'dart:developer' as console;

import 'package:crowfunding_project/data/models/project_model.dart';
import 'package:crowfunding_project/domain/usecases/projects/get_projects_usecase.dart';
import 'package:get/get.dart';

class HomeViewmodel extends GetxController {
  final GetProjectsUsecase getProjectsUsecase;
  HomeViewmodel(this.getProjectsUsecase);

  // Reactive projects data
  final RxList<ProjectModel> projects = <ProjectModel>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    console.log('[HomeViewModel] onInit');
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
