import 'package:crowfunding_project/core/di/auth_bindings.dart';
import 'package:crowfunding_project/core/di/projects_bindings.dart';
import 'package:crowfunding_project/navigation/base_screen.dart';
import 'package:crowfunding_project/ui/features/auth/role_selection_screen.dart';
import 'package:crowfunding_project/ui/features/auth/sign_in_screen.dart';
import 'package:crowfunding_project/ui/features/auth/sign_up_association_screen.dart';
import 'package:crowfunding_project/ui/features/auth/sign_up_person_screen.dart';
import 'package:crowfunding_project/ui/features/dashboard/dashboard_screen.dart';
import 'package:crowfunding_project/ui/features/onboarding/onboarding_screen.dart';
import 'package:crowfunding_project/ui/features/profile/profile_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => BaseScreen(), binding: ProjectsBindings()),
    GetPage(name: '/signin', page: () => const SignInScreen(), binding: AuthBindings()),
    GetPage(name: '/signup-association', page: () => SignUpAssociationScreen()),
    GetPage(name: '/signup-person', page: () => SignUpPersonScreen()),
    GetPage(name: '/role-selection', page: () => const RoleSelectionScreen()),
    GetPage(name: '/onboarding', page: () => const OnboardingScreen()),
    GetPage(name: '/profile', page: () => const ProfileScreen()),
    GetPage(name: '/dashboard', page: () {
      return DashboardScreen();
    },)
  ];
}
