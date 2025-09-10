import 'package:crowfunding_project/core/data/models/project_model.dart';
import 'package:crowfunding_project/core/data/uistate.dart';
import 'package:crowfunding_project/ui/features/projects/completed_project_container.dart';
import 'package:crowfunding_project/ui/features/projects/project_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompletedProjectScreen extends StatefulWidget {
  const CompletedProjectScreen({super.key});

  @override
  State<CompletedProjectScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<CompletedProjectScreen> {
  final ProjectsViewmodel projectsViewmodel = Get.find<ProjectsViewmodel>();
  final ScrollController scrollController = ScrollController();


  void scrollToTop(){
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final state = projectsViewmodel.projectsState.value;
      final projects = projectsViewmodel.projects;
      final hasNewProjects = projectsViewmodel.hasNewProjects.value;

      return Stack(
        children: [
          CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child:
                  state is UiStateLoading
                        ? const Center(child: CircularProgressIndicator())
                        : projects.isEmpty
                        ? const Center(child: Text('No projects available'))
                        : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: projects.length,
                          itemBuilder: (context, index) {
                            final ProjectModel project = projects[index];
                            return CompletedProjectContainer(project: project);
                          },
                        ),
              ),
            ],
          ),
              if (hasNewProjects)
                Positioned(
                  top: 16,
                  left: 16,
                  right: 16,
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 4,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                      ),
                      onPressed: () {
                        scrollToTop();
                        projectsViewmodel.showNewProjects();
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Actualiser les projets'),
                    ),
                ),
        ],
      );
    });
  }
}