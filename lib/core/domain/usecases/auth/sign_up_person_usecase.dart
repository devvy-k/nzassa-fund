import 'package:crowfunding_project/core/data/models/person_model.dart';
import 'package:crowfunding_project/core/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPersonUsecase {
  final AuthRepository _authRepository;
  SignUpPersonUsecase(this._authRepository);
  Future<User> call(PersonModel person, String password) async {
    return await _authRepository.signUpPerson(person, password);
  }
}