import 'package:crowfunding_project/core/constants/nav_ids.dart';
import 'package:crowfunding_project/core/domain/entities/project.dart';
import 'package:crowfunding_project/ui/features/collect_creation/collect_creation_page.dart';
import 'package:crowfunding_project/ui/features/collect_creation/project_preview.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CollectCreationNav extends StatelessWidget {
  const CollectCreationNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NavIds.collectCreation),
      onGenerateRoute: (settings) { 
        if (settings.name == '/collect-preview') {
          final project = settings.arguments as Project;
          return GetPageRoute(
            settings: settings,
            routeName: '/collectCreation',
            page: () => ProjectPreview(project: project),
          );
        } else {
          return GetPageRoute(
            routeName: '/collectCreation',
            page: () => const CollectCreationPage()
          );
        }
      },
    );
  }
}