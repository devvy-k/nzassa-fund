import 'package:crowfunding_project/core/data/models/association_model.dart';
import 'package:crowfunding_project/core/data/models/person_model.dart';
import 'package:crowfunding_project/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDataSource {
  final AuthService _authService;
  AuthRemoteDataSource(this._authService);

  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    final credential = await _authService.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential;
  }

  Future<UserCredential> signUpPerson(PersonModel person, String password) async {
    final credential = await _authService.signUpPerson(
      person: person,
      password: password,
    );
    return credential;
  }

  Future<UserCredential> signUpAssociation(AssociationModel association, String password) async {
    final credential = await _authService.signUpAssociation(
      association: association,
      password: password,
    );
    return credential;
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _authService.sendPasswordResetEmail(email);
  }
}