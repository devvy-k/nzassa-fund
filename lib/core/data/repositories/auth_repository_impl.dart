import 'package:crowfunding_project/core/data/datasources/auth_remote_datasource.dart';
import 'package:crowfunding_project/core/data/models/association_model.dart';
import 'package:crowfunding_project/core/data/models/person_model.dart';
import 'package:crowfunding_project/core/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  AuthRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    return await _authRemoteDataSource.signInWithEmailAndPassword(email, password);
  }
  @override
  Future<User> signUpPerson(PersonModel person, String password) async {
    return await _authRemoteDataSource.signUpPerson(person, password);
  }
  @override
  Future<User> signUpAssociation(AssociationModel association, String password) async {
    return await _authRemoteDataSource.signUpAssociation(association, password);
  }
  @override
  Future<void> sendPasswordResetEmail(String email) async {
    return await _authRemoteDataSource.sendPasswordResetEmail(email);
  }
  @override
  Future<void> signOut() async {
    return await _authRemoteDataSource.signOut();
  }
}