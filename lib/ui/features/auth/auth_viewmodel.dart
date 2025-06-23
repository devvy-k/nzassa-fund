import 'dart:developer' as console;

import 'package:crowfunding_project/core/data/models/association_model.dart';
import 'package:crowfunding_project/core/data/uistate.dart';
import 'package:crowfunding_project/core/domain/usecases/auth/sign_in_usecase.dart';
import 'package:crowfunding_project/core/domain/usecases/auth/sign_out_usecase.dart';
import 'package:crowfunding_project/core/domain/usecases/auth/sign_up_association_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthViewmodel extends GetxController {
  final SignInUsecase signInUsecase;
  final SignUpAssociationUsecase signUpAssociationUsecase;
  final SignOutUsecase signOutUsecase;
  AuthViewmodel(
    this.signInUsecase,
    this.signUpAssociationUsecase,
    this.signOutUsecase,
  );

  final Rx<UiState<UserCredential>?> signInState = Rx<UiState<UserCredential>?>(
    null,
  );
  final Rx<UiState<UserCredential>?> signUpState = Rx<UiState<UserCredential>?>(
    null,
  );

  Future<UiState<UserCredential>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await signInUsecase.call(email, password);
      final state = UiStateSuccess<UserCredential>(credential);
      signInState.value = state;
      return state;
    } catch (e) {
      final error = UiStateError<UserCredential>(e.toString());
      signInState.value = error;
      console.log('Sign-in error: ${e.toString()}');
      return error;
    }
  }

  Future<void> signUpAssociation({
    required AssociationModel association,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await signUpAssociationUsecase.call(
        association,
        password,
      );
      signUpState.value = UiStateSuccess(userCredential);
    } catch (e) {
      signUpState.value = UiStateError(e.toString());
      console.log('Sign-up error: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    try {
      signOutUsecase.call();
    } catch (e) {
      console.log('Sign-in error: ${e.toString()}');
    }
  }
}
