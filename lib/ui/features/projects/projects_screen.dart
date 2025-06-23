import 'package:crowfunding_project/core/domain/entities/project.dart';
import 'package:crowfunding_project/ui/features/projects/payment_status.dart';
import 'package:crowfunding_project/ui/features/projects/project_container.dart';
import 'package:crowfunding_project/ui/features/projects/project_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart'
    show Artboard, RiveAnimation, SMITrigger, StateMachineController;

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final ProjectsViewmodel projectsViewmodel = Get.find<ProjectsViewmodel>();
  final ScrollController scrollController = ScrollController();

  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;
  late SMITrigger confetti;

  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? controller = StateMachineController.fromArtboard(
      artboard,
      'State Machine 1',
    );
    artboard.addController(controller!);
    return controller;
  }


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
      final paymentStatus = projectsViewmodel.paymentStatus.value;
      final isLoading = projectsViewmodel.isLoading.value;
      final projects = projectsViewmodel.projects;
      final hasNewProjects = projectsViewmodel.hasNewProjects.value;

      return Stack(
        children: [
          CustomScrollView(
            controller: scrollController,
            slivers: [
              if (hasNewProjects)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        scrollToTop();
                        projectsViewmodel.hasNewProjects.value = false;
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Actualiser les projets'),
                    ),
                  ),
                ),
              SliverToBoxAdapter(
                child:
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : projects.isEmpty
                        ? const Center(child: Text('No projects available'))
                        : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: projects.length,
                          itemBuilder: (context, index) {
                            final Project project = projects[index];
                            return ProjectContainer(project: project);
                          },
                        ),
              ),
            ],
          ),

          /// Animation Check
          if (paymentStatus == PaymentStatus.loading)
            CustomPositionned(
              child: RiveAnimation.asset(
                'assets/rive/check.riv',
                onInit: (artboard) {
                  final controller = getRiveController(artboard);
                  check = controller.findSMI('Check') as SMITrigger;

                  /// ⏳ On attend la fin du build pour lancer l'animation
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    check.fire();
                  });
                },
              ),
            ),

          /// Animation Error
          if (paymentStatus == PaymentStatus.error)
            CustomPositionned(
              child: RiveAnimation.asset(
                'assets/rive/check.riv',
                onInit: (artboard) {
                  final controller = getRiveController(artboard);
                  error = controller.findSMI('Error') as SMITrigger;

                  /// ⏳ On attend la fin du build pour lancer l'animation
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    error.fire();
                  });
                },
              ),
            ),

          /// Animation confetti
          if (paymentStatus == PaymentStatus.success)
            CustomPositionned(
              child: Transform.scale(
                scale: 7, // Réduction du scale pour éviter bugs visuels
                child: RiveAnimation.asset(
                  'assets/rive/confetti(1).riv',
                  onInit: (artboard) {
                    final controller = getRiveController(artboard);
                    confetti =
                        controller.findSMI('Trigger explosion') as SMITrigger;

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      confetti.fire();
                    });
                  },
                ),
              ),
            ),
        ],
      );
    });
  }
}

class CustomPositionned extends StatelessWidget {
  const CustomPositionned({super.key, required this.child, this.size = 100});

  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          Spacer(),
          SizedBox(height: size, width: size, child: child),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
