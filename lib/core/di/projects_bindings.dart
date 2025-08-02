import 'package:crowfunding_project/core/domain/usecases/comments/add_comment_usecase.dart';
import 'package:crowfunding_project/core/domain/usecases/comments/delete_comment_usecase.dart';
import 'package:crowfunding_project/core/domain/usecases/comments/get_comment_usecase.dart';
import 'package:crowfunding_project/core/domain/usecases/projects/create_project_usecase.dart';
import 'package:crowfunding_project/core/domain/usecases/projects/toggle_like_project_usecase.dart';
import 'package:crowfunding_project/services/auth_service.dart';
import 'package:crowfunding_project/services/firestrore_service.dart';
import 'package:crowfunding_project/core/data/datasources/projects_remote_datasource.dart';
import 'package:crowfunding_project/core/data/repositories/project_repository_impl.dart';
import 'package:crowfunding_project/core/domain/repositories/project_repository.dart';
import 'package:crowfunding_project/core/domain/usecases/projects/get_projects_usecase.dart';
import 'package:crowfunding_project/navigation/base_controller.dart';
import 'package:crowfunding_project/ui/features/collect_creation/collect_creation_viewmodel.dart';
import 'package:crowfunding_project/ui/features/comments/comment_viewmodel.dart';
import 'package:crowfunding_project/ui/features/projects/project_viewmodel.dart';
import 'package:get/get.dart';

class ProjectsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthService(), fenix: true);
    // Shared service
    Get.lazyPut(() => FirestroreService(), fenix: true);

    // Data source
    Get.lazyPut(() => ProjectsRemoteDatasource(Get.find<FirestroreService>()), fenix: true);

    // Repository implementation
    Get.lazyPut<ProjectRepository>(
      () => ProjectRepositoryImpl(Get.find<ProjectsRemoteDatasource>()), fenix: true,
    );

    // Use case
    Get.lazyPut(() => GetProjectsUsecase(Get.find<ProjectRepository>()));
    Get.lazyPut(() => CreateProjectUseCase(Get.find<ProjectRepository>()), fenix: true);
    Get.lazyPut(() => ToggleLikeProjectUsecase(Get.find<ProjectRepository>()));
    Get.lazyPut(() => AddCommentUsecase(Get.find<ProjectRepository>()), fenix: true);
    Get.lazyPut(() => DeleteCommentUsecase(Get.find<ProjectRepository>()), fenix: true);
    Get.lazyPut(() => GetCommentUsecase(Get.find<ProjectRepository>()), fenix: true);

    // ViewModel
    Get.lazyPut(
      () => ProjectsViewmodel(
        Get.find<GetProjectsUsecase>(),
        Get.find<ToggleLikeProjectUsecase>(),
      ),
    );
    Get.lazyPut(
      () => CollectCreationViewmodel(Get.find<CreateProjectUseCase>()), fenix: true,
    );
    Get.lazyPut(
      () => CommentViewmodel(
        Get.find<GetCommentUsecase>(),
        Get.find<AddCommentUsecase>(),
        Get.find<DeleteCommentUsecase>()
      ),
      fenix: true
    );

    // Controller
    Get.lazyPut(() => BaseController());
  }
}
