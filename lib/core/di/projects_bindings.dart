import 'package:crowfunding_project/services/firestrore_service.dart';
import 'package:crowfunding_project/core/data/datasources/projects_remote_datasource.dart';
import 'package:crowfunding_project/core/data/repositories/project_repository_impl.dart';
import 'package:crowfunding_project/core/domain/repositories/project_repository.dart';
import 'package:crowfunding_project/core/domain/usecases/projects/get_projects_usecase.dart';
import 'package:crowfunding_project/navigation/base_controller.dart';
import 'package:crowfunding_project/ui/features/collect_creation/collect_creation_viewmodel.dart';
import 'package:crowfunding_project/ui/features/projects/project_viewmodel.dart';
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
    Get.lazyPut(() => ProjectsViewmodel(Get.find<GetProjectsUsecase>()));
    Get.lazyPut(() => CollectCreationViewmodel());

    // Controller
    Get.lazyPut(() => BaseController());
  }
}
