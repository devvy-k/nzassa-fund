import 'dart:developer' as console;

import 'package:crowfunding_project/core/domain/usecases/auth/sign_in_usecase.dart';
import 'package:get/get.dart';

class AuthViewmodel extends GetxController {
  final SignInUsecase signInUsecase;
  AuthViewmodel(this.signInUsecase);

  RxBool isLoading = false.obs;
  RxString? error = ''.obs;

  Future<void> signIn(String email, String password) async {
    isLoading.value = true;
    try {
      await signInUsecase.call(email, password);
      error = null;
    } catch (e) {
      error?.value = e.toString();
      console.log('Sign-in error: $error');
    } finally {
      isLoading.value = false;
    }
  }
}