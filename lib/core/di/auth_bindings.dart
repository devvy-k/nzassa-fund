import 'package:crowfunding_project/core/data/datasources/auth_remote_datasource.dart';
import 'package:crowfunding_project/core/data/repositories/auth_repository_impl.dart';
import 'package:crowfunding_project/core/domain/repositories/auth_repository.dart';
import 'package:crowfunding_project/core/domain/usecases/auth/sign_in_usecase.dart';
import 'package:crowfunding_project/services/auth_service.dart';
import 'package:crowfunding_project/ui/features/auth/auth_viewmodel.dart';
import 'package:get/get.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    // Auth service
    Get.lazyPut(() => AuthService());

    // Data source
    Get.lazyPut(() => AuthRemoteDataSource(Get.find<AuthService>()));

    // Repository implementation
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(Get.find<AuthRemoteDataSource>()),
    );

    // Use cases
    Get.lazyPut(() => SignInUsecase(Get.find<AuthRepository>()));

    // ViewModel
    Get.lazyPut(() => AuthViewmodel(Get.find<SignInUsecase>()));
  }
}
