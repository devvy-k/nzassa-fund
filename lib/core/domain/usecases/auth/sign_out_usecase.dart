import 'package:crowfunding_project/core/domain/repositories/auth_repository.dart';

class SignOutUsecase {
  final AuthRepository _authRepository;

  SignOutUsecase(this._authRepository);

  Future<void> call() async {
    return await _authRepository.signOut();
  }
}