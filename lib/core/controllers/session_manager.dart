import 'dart:developer' as console;

import 'package:crowfunding_project/core/data/models/user_profile.dart';
import 'package:get/get.dart';

class SessionManager extends GetxService {
  final Rxn<UserProfile> _userProfile = Rxn<UserProfile>();

  UserProfile? get user => _userProfile.value;
  bool get isLoggedIn => _userProfile.value != null;

  void setUser(UserProfile profile) {
    _userProfile.value = profile;
    console.log('[SessionManage] Utilisateur connecté : ${profile.email}');
  }

  void clearUser() {
    _userProfile.value = null;
  }
}
