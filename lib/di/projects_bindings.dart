import 'package:crowfunding_project/core/services/firestrore_service.dart';
import 'package:crowfunding_project/data/datasources/projects_remote_datasource.dart';
import 'package:crowfunding_project/data/repositories/project_repository_impl.dart';
import 'package:crowfunding_project/domain/repositories/project_repository.dart';
import 'package:crowfunding_project/domain/usecases/projects/get_projects_usecase.dart';
import 'package:crowfunding_project/ui/features/home/home_viewmodel.dart';
import 'package:get/get.dart';

class ProjectsBindings extends Bindings {
  @override
  void dependencies() {
    // Shared service
    Get.lazyPut(() => FirestroreService());

    // Data source
    Get.lazyPut(() => ProjectsRemoteDatasource(Get.find<FirestroreService>()));

    // Repository implementation
    Get.lazyPut<ProjectRepository>(
      () => ProjectRepositoryImpl(Get.find<ProjectsRemoteDatasource>()),
    );

    // Use case
    Get.lazyPut(() => GetProjectsUsecase(Get.find<ProjectRepository>()));

    // ViewModel
    Get.lazyPut(() => HomeViewmodel(Get.find<GetProjectsUsecase>()));
  }
}
