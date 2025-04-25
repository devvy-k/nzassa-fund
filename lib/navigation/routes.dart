import 'package:crowfunding_project/di/projects_bindings.dart';
import 'package:crowfunding_project/ui/features/home/home_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/home', page: () => HomePage(), binding: ProjectsBindings()),
  ];
}
