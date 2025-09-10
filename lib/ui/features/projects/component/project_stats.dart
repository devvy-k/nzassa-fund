import 'package:crowfunding_project/core/controllers/session_manager.dart';
import 'package:crowfunding_project/core/data/models/project_model.dart';
import 'package:crowfunding_project/ui/features/comments/comment_bottom_sheet.dart';
import 'package:crowfunding_project/ui/features/projects/component/project_button.dart';
import 'package:crowfunding_project/ui/features/projects/project_viewmodel.dart';
import 'package:crowfunding_project/utils/payment_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectStats extends StatefulWidget {
  final ProjectModel project;

  const ProjectStats({super.key, required this.project});

  @override
  State<ProjectStats> createState() => _ProjectStatsState();
}

class _ProjectStatsState extends State<ProjectStats> {
  final projectsViewmodel = Get.find<ProjectsViewmodel>();
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          final isLoggedIn = Get.find<SessionManager>().isLoggedIn;
          return Row(
            children: [
              ProjectButton(
                icon: Icon(Icons.healing_outlined, size: 16.0),
                onTap: () {
                  if (isLoggedIn) {
                    PaymentBottomSheet.show(context);
                  } else {
                    Get.toNamed('/signin');
                  }
                },
              ),
              ProjectButton(
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  size: 16.0,
                  color:
                      isLiked
                          ? Colors.red
                          : Theme.of(context).colorScheme.onSurface,
                ),
                onTap: () {
                  if (isLoggedIn) {
                    setState(() {
                      isLiked = !isLiked;
                    });
                    projectsViewmodel.toggleLikeProject(
                      widget.project.id,
                      Get.find<SessionManager>().user!.id,
                    );
                  } else {
                    Get.toNamed('/signin');
                  }
                },
              ),
              ProjectButton(
                icon: Icon(Icons.comment_outlined, size: 16.0),
                onTap: () {
                  if (isLoggedIn) {
                    CommentsBottomSheet.show(
                      context,
                      widget.project,
                    );
                  } else {
                    Get.toNamed('/signin');
                  }
                },
              ),
              ProjectButton(
                icon: Icon(Icons.send, size: 16.0),
                onTap: () => print('send'),
              ),
            ],
          );
        }),
      ],
    );
  }
}