import 'package:crowfunding_project/core/services/firestrore_service.dart';
import 'package:crowfunding_project/data/datasources/posts_remote_datasource.dart';
import 'package:crowfunding_project/data/repositories/post_repository_impl.dart';
import 'package:crowfunding_project/domain/repositories/post_repository.dart';
import 'package:crowfunding_project/domain/usecases/posts/get_posts_usecase.dart';
import 'package:crowfunding_project/ui/features/home/home_viewmodel.dart';
import 'package:get/get.dart';

class PostsBindings extends Bindings {
  @override
  void dependencies() {
    // Shared service
    Get.lazyPut(() => FirestroreService());

    // Data source
    Get.lazyPut(() => PostsRemoteDatasource(Get.find<FirestroreService>()));

    // Repository implementation
    Get.lazyPut<PostRepository>(() => PostRepositoryImpl(Get.find<PostsRemoteDatasource>()));

    // Use case
    Get.lazyPut(() => GetPostsUsecase(Get.find<PostRepository>()));

    // ViewModel
    Get.lazyPut(() => HomeViewmodel(Get.find<GetPostsUsecase>()));
  }
}