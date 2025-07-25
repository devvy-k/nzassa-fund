import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:crowfunding_project/core/controllers/session_manager.dart';
import 'package:crowfunding_project/core/data/models/project_model.dart';
import 'package:crowfunding_project/core/domain/entities/project.dart';
import 'package:crowfunding_project/ui/features/projects/component/profile_avatar.dart';
import 'package:crowfunding_project/ui/features/projects/project_viewmodel.dart';
import 'package:crowfunding_project/utils/payment_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProjectContainer extends StatelessWidget {
  final ProjectModel project;
  const ProjectContainer({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _ProjectHeader(project: project),
                const SizedBox(height: 4.0),
                Text(
                  project.title != null ? project.title! : 'No title available',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4.0),
                Text(
                  project.content != null
                      ? project.content!
                      : 'No content available',
                ),
                SizedBox(height: 6.0),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CachedNetworkImage(
              imageUrl:
                  'https://images.pexels.com/photos/12199063/pexels-photo-12199063.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: _ProjectBudget(project: project),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: _ProjectStats(project: project),
          ),
        ],
      ),
    );
  }
}

class _ProjectHeader extends StatelessWidget {
  final Project project;
  const _ProjectHeader({required this.project});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(
          userProfileImageUrl:
              'https://images.pexels.com/photos/6646918/pexels-photo-6646918.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.author.name != null
                    ? project.author.name!
                    : 'Unknown Author',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text(
                    project.createdAt.toString(),
                    style: const TextStyle(fontSize: 12.0),
                  ),
                  const SizedBox(width: 8.0),
                  const Icon(Icons.public, size: 12.0),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () => print('More options'),
          icon: const Icon(Icons.more_horiz),
        ),
      ],
    );
  }
}

class _ProjectStats extends StatefulWidget {
  final ProjectModel project;

  const _ProjectStats({required this.project});

  @override
  State<_ProjectStats> createState() => _ProjectStatsState();
}

class _ProjectStatsState extends State<_ProjectStats> {
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
              _ProjectButton(
                icon: Icon(Icons.healing_outlined, size: 16.0),
                onTap: () {
                  if (isLoggedIn) {
                    PaymentBottomSheet.show(context);
                  } else {
                    Get.toNamed('/signin');
                  }
                },
              ),
              _ProjectButton(
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
              _ProjectButton(
                icon: Icon(Icons.comment_outlined, size: 16.0),
                onTap: () => print('Comment'),
              ),
              _ProjectButton(
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

class _ProjectButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback onTap;
  final countValue = 250;

  const _ProjectButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 4.0),
                Text(
                  countValue.toString(),
                  style: const TextStyle(fontSize: 12.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectBudget extends StatefulWidget {
  final ProjectModel project;
  const _ProjectBudget({required this.project});

  @override
  State<_ProjectBudget> createState() => _ProjectBudgetState();
}

class _ProjectBudgetState extends State<_ProjectBudget> {
  double collected = 1850600;
  double target = 2000000;
  bool showTooltip = false;

  Timer? _timer;

  void _onTapBar() {
    setState(() {
      showTooltip = true;
    });

    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 2), () {
      setState(() {
        showTooltip = false;
      });
    });
  }

  String formatAmount(double amount) {
    return NumberFormat("#,##0", "fr_FR").format(amount) + ' FCFA';
  }

  @override
  Widget build(BuildContext context) {
    final progress = (widget.project.totalCollected! /
            widget.project.collectGoal)
        .clamp(0.0, 1.0);
    final percentage = (progress * 100).toStringAsFixed(1);

    return LayoutBuilder(
      builder: (context, constraints) {
        final barWidth = constraints.maxWidth;
        final tooltipX = (progress * barWidth).clamp(0.0, barWidth - 90);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: _onTapBar,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.orange.shade100,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.transparent,
                        color: Colors.orange,
                        minHeight: 20,
                      ),
                    ),
                  ),
                  Text(
                    '$percentage%',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (showTooltip)
                    Positioned(
                      left: tooltipX,
                      top: -35,
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            formatAmount(collected),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 40),
                Text(
                  '🎯 ${formatAmount((widget.project.collectGoal ?? 0).toDouble())}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

