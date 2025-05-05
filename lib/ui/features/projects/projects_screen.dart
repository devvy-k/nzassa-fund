import 'package:crowfunding_project/core/domain/entities/project.dart';
import 'package:crowfunding_project/ui/features/projects/project_container.dart';
import 'package:crowfunding_project/ui/features/projects/project_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectsScreen extends StatelessWidget {
   ProjectsScreen({super.key});

  final ProjectsViewmodel projectsViewmodel = Get.find<ProjectsViewmodel>();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Obx(() {
                if (projectsViewmodel.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (projectsViewmodel.projects.isEmpty) {
                  return const Center(child: Text('No projects available'));
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: projectsViewmodel.projects.length,
                  itemBuilder: (context, index) {
                    final Project project = projectsViewmodel.projects[index];
                    return ProjectContainer(project: project);
                  },
                );
              }),
        
        )
      ],
    );
  }
}