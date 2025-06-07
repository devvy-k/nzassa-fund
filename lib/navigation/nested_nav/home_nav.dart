import 'package:crowfunding_project/core/constants/nav_ids.dart';
import 'package:crowfunding_project/ui/features/home_page.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeNav extends StatelessWidget {
  const HomeNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NavIds.home),
      onGenerateRoute: (settings) {
        if (settings.name == '/home' || settings.name == null || settings.name == '/') {
          return GetPageRoute(
            routeName: '/home',
            page: () => HomePage(),
          );
        }
      },
    );
  }
}