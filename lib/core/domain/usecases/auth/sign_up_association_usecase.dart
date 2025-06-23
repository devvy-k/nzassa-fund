import 'package:crowfunding_project/core/data/models/association_model.dart';
import 'package:crowfunding_project/core/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpAssociationUsecase {
  final AuthRepository _authRepository;
  SignUpAssociationUsecase(this._authRepository);
  Future<UserCredential> call(AssociationModel association, String password) async {
    return await _authRepository.signUpAssociation(association, password);
  }
}