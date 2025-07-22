import 'dart:async';
import 'dart:developer' as console;

import 'package:crowfunding_project/core/controllers/session_manager.dart';
import 'package:crowfunding_project/core/data/models/project_model.dart';
import 'package:crowfunding_project/core/data/models/user_profile.dart';
import 'package:crowfunding_project/core/data/uistate.dart';
import 'package:crowfunding_project/core/domain/usecases/projects/get_projects_usecase.dart';

import 'package:crowfunding_project/ui/features/projects/payment_status.dart';
import 'package:get/get.dart';

class ProjectsViewmodel extends GetxController {
  final GetProjectsUsecase getProjectsUsecase;
  ProjectsViewmodel(this.getProjectsUsecase);

  // Reactive projects data
  final RxList<ProjectModel> projects = <ProjectModel>[].obs;
  final RxList<ProjectModel> _lastProjects = <ProjectModel>[].obs;
  final RxBool hasNewProjects = false.obs;

  final Rx<UiState<List<ProjectModel>>?> projectsState = Rx<UiState<List<ProjectModel>>?>(null);

  final Rx<PaymentStatus> paymentStatus = PaymentStatus.none.obs;

  StreamSubscription<List<ProjectModel>>? _projectsSubscription;
  StreamSubscription? _authSubscription;

  List<String>? userPreferredCategories;

  void simulatePayment(bool success) async {
    if (success) {
      paymentStatus.value = PaymentStatus.loading;
      await Future.delayed(const Duration(seconds: 4));
      paymentStatus.value = PaymentStatus.success;
    } else {
      paymentStatus.value = PaymentStatus.error;
    }

    await Future.delayed(const Duration(seconds: 2));
    paymentStatus.value = PaymentStatus.none;
  }

  @override
  void onInit() {
    console.log('[ProjectsViewmodel] onInit');
    final session = Get.find<SessionManager>().user;

      if (session != null && session.userType == UserType.person) {
        userPreferredCategories = session.preferredCategories;
      } else {
        userPreferredCategories = null;
      }

      fetchProjects();
    super.onInit();
  }

  void fetchProjects() async {
    _projectsSubscription?.cancel();
    projectsState.value = UiStateLoading();

    _projectsSubscription = getProjectsUsecase
        .call(preferredCategories: userPreferredCategories)
        .listen(
          (fetchedProjects) {
            projectsState.value = UiStateSuccess(fetchedProjects);

            if (projects.isEmpty) {
              projects.assignAll(fetchedProjects);
              _lastProjects.assignAll(fetchedProjects);
              return; 
            }

            // Check if there are new projects compared to the last fetched
            if (!_areEqual(fetchedProjects, _lastProjects)) {
              _lastProjects.assignAll(fetchedProjects);
              hasNewProjects.value = true;
            }
          },
          onError: (error) {
            console.log('[ProjectsViewmodel] Error fetching projects: $error');
            projectsState.value = UiStateError(error);
          },
        );
  }

  void showNewProjects() {
    projects.assignAll(_lastProjects);
    hasNewProjects.value = false;
  }

  bool _areEqual(List<ProjectModel> list1, List<ProjectModel> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i].id != list2[i].id) return false;
    }
    return true;
  }

  @override
  void onClose() {
    _authSubscription?.cancel();
    _projectsSubscription?.cancel();
    super.onClose();
  }

}
