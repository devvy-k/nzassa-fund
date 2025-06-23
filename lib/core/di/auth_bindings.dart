import 'package:crowfunding_project/core/data/datasources/auth_remote_datasource.dart';
import 'package:crowfunding_project/core/data/repositories/auth_repository_impl.dart';
import 'package:crowfunding_project/core/domain/repositories/auth_repository.dart';
import 'package:crowfunding_project/core/domain/usecases/auth/sign_in_usecase.dart';
import 'package:crowfunding_project/core/domain/usecases/auth/sign_out_usecase.dart';
import 'package:crowfunding_project/core/domain/usecases/auth/sign_up_association_usecase.dart';
import 'package:crowfunding_project/services/auth_service.dart';
import 'package:crowfunding_project/ui/features/auth/auth_viewmodel.dart';
import 'package:get/get.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    // Auth service (Firebase Auth wrapper)
    Get.lazyPut(() => AuthService(), fenix: true);

    // Remote data source
    Get.lazyPut(() => AuthRemoteDataSource(Get.find<AuthService>()), fenix: true);

    // Repository
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(Get.find<AuthRemoteDataSource>()),
      fenix: true,
    );

    // Use cases
    Get.lazyPut(() => SignInUsecase(Get.find<AuthRepository>()), fenix: true);
    Get.lazyPut(() => SignUpAssociationUsecase(Get.find<AuthRepository>()), fenix: true);
    Get.lazyPut(() => SignOutUsecase(Get.find<AuthRepository>()), fenix: true);

    // ViewModel
    Get.lazyPut(
      () => AuthViewmodel(
        Get.find<SignInUsecase>(),
        Get.find<SignUpAssociationUsecase>(),
        Get.find<SignOutUsecase>()
      ),
      fenix: true,
    );
  }
}

