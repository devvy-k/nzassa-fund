import 'package:crowfunding_project/core/domain/repositories/auth_repository.dart';

class SendPasswordResetUsecase {
  final AuthRepository _authRepository;

  SendPasswordResetUsecase(this._authRepository);

  Future<void> call(String email) async {
    return _authRepository.sendPasswordResetEmail(email);
  }
}