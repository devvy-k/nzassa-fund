import 'package:crowfunding_project/core/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInUsecase {
  final AuthRepository _authRepository;

  SignInUsecase(this._authRepository);

  Future<User> call(String email, String password) async {
    return await _authRepository.signInWithEmailAndPassword(email, password);
  }
}