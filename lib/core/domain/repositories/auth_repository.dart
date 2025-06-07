import 'package:crowfunding_project/core/data/models/association_model.dart';
import 'package:crowfunding_project/core/data/models/person_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> signUpPerson(PersonModel person, String password);
  Future<User> signUpAssociation(AssociationModel association, String password);
  Future<void> sendPasswordResetEmail(String email);
  Future<void> signOut();
}