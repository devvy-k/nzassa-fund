import 'package:crowfunding_project/core/data/models/association_model.dart';
import 'package:crowfunding_project/core/data/models/person_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password}) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  Future<UserCredential> signUpPerson({
    required PersonModel person,
    required String password,
}) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: person.email, password: password);
      // Additional logic to save user details in Firestore can be added here
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  Future<UserCredential> signUpAssociation({
    required AssociationModel association,
    required String password,
}) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: association.emailAssociation, password: password);
      // Additional logic to save association details in Firestore can be added here
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  // Update user profile
  // Delete user account 
}