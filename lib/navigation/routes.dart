import 'package:crowfunding_project/core/di/projects_bindings.dart';
import 'package:crowfunding_project/navigation/base_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => BaseScreen(), binding: ProjectsBindings()),
  ];
}
