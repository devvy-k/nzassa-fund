import 'package:crowfunding_project/domain/entities/project.dart';
import 'package:crowfunding_project/ui/features/home/component/project_container.dart';
import 'package:crowfunding_project/ui/features/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeViewmodel homeViewModel = Get.find<HomeViewmodel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            title: const Text(
              "N'Zassa Fund",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.2,
              ),
            ),
            centerTitle: false,
            floating: true,
          ),

          /// Obx doit envelopper un widget indépendant
          SliverToBoxAdapter(
            child: Obx(() {
              if (homeViewModel.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (homeViewModel.projects.isEmpty) {
                return const Center(child: Text('No projects available'));
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: homeViewModel.projects.length,
                itemBuilder: (context, index) {
                  final Project project = homeViewModel.projects[index];
                  return ProjectContainer(project: project);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
