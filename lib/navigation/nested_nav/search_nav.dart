import 'package:crowfunding_project/core/constants/nav_ids.dart';
import 'package:crowfunding_project/ui/features/search/search_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SearchNav extends StatelessWidget {
  const SearchNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NavIds.search),
      onGenerateRoute: (settings) {
        if (settings.name == '/search' || settings.name == null || settings.name == '/') {
          return GetPageRoute(
            routeName: '/search',
            page: () => const SearchScreen(),
          );
        }
      },
    );
  }
}