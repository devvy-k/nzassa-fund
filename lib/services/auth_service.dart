import 'dart:developer' as console;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crowfunding_project/core/constants/firebase_contants.dart';
import 'package:crowfunding_project/core/controllers/session_manager.dart';
import 'package:crowfunding_project/core/data/models/association_model.dart';
import 'package:crowfunding_project/core/data/models/person_model.dart';
import 'package:crowfunding_project/core/data/models/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<UserCredential> signUpPerson({
    required PersonModel person,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: person.email,
            password: password,
          );
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
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: association.emailAssociation,
            password: password,
          );

      final userId = userCredential.user!.uid;

      final updatedAssociation = association.copyWith(id: userId);

      _firestore
          .collection(FirebaseConstants.usersCollection)
          .doc(userId)
          .set(updatedAssociation.toJson());

      return userCredential;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    Get.find<SessionManager>().clearUser();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  Future<void> handleSignIn(User user) async {
    final docSnapshot =
        await FirebaseFirestore.instance
            .collection(FirebaseConstants.usersCollection)
            .doc(user.uid)
            .get();
    
    console.log('[handleSignIn] Récupération du profil pour l\'utilisateur : ${user.uid}');

    if (docSnapshot.exists) {
      final data = docSnapshot.data()!;
      console.log('[handleSignIn] Profil récupéré : $data');
      late final UserProfile profile;

      if (data.containsKey('firstName')) {
        // C'est une Person
        profile = UserProfile(
          id: user.uid,
          name: '${data['firstName']} ${data['lastName']}',
          profilePicture: data['profilePicture'],
          email: data['email'],
          userType: UserType.person,
          preferredCategories: List<String>.from(
            data['preferredCategories'] ?? [],
          ),
        );
      } else {
        // C'est une Association
        profile = UserProfile(
          id: user.uid,
          name: data['name'],
          profilePicture: data['profilePicture'],
          email: data['emailAssociation'],
          userType: UserType.association,
        );
      }

      console.log('[handleSignIn] Profile récupéré : $profile');

      Get.find<SessionManager>().setUser(profile);
    }
  }

  // Update user profile
  // Delete user account
}
