import 'dart:async';
import 'dart:developer' as console;
import 'package:crowfunding_project/core/constants/nav_ids.dart';
import 'package:crowfunding_project/core/data/models/project_model.dart';
import 'package:crowfunding_project/core/data/uistate.dart';
import 'package:crowfunding_project/core/domain/entities/project.dart';
import 'package:crowfunding_project/navigation/base_controller.dart';
import 'package:crowfunding_project/ui/features/collect_creation/collect_creation_viewmodel.dart';
import 'package:crowfunding_project/ui/features/projects/component/profile_avatar.dart';
import 'package:crowfunding_project/utils/media_pager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProjectPreview extends StatefulWidget {
  final ProjectModel project;
  const ProjectPreview({super.key, required this.project});

  @override
  State<ProjectPreview> createState() => _ProjectPreviewState();
}

class _ProjectPreviewState extends State<ProjectPreview> {
  final CollectCreationViewmodel collectCreationViewmodel =
      Get.find<CollectCreationViewmodel>();

  void _lancerCollecte() {
    collectCreationViewmodel.createProjectState.value = UiStateLoading();

    try {
      collectCreationViewmodel.createProject(widget.project);
      Future.delayed(const Duration(seconds: 2), () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Collecte lancée avec succès !'),
            duration: Duration(seconds: 2),
          ),
        );
      });
      Get.until(((route) => route.isFirst));
      BaseController.to.changeIndex(NavIds.home);
    } catch (e) {
      console.log('[ProjectPreview] Error launching collection: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _ProjectHeader(project: widget.project),
                        const SizedBox(height: 4.0),
                        Text(
                          widget.project.content != null
                              ? widget.project.content!
                              : 'No content available',
                        ),
                        SizedBox(height: 6.0),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: MediaPager(
                      mediaUrls: [
                      'https://images.pexels.com/photos/31095000/pexels-photo-31095000.jpeg?_gl=1*1bjxwzb*_ga*NTk1MjM5NjEuMTc0NDkzMDE5NQ..*_ga_8JE65Q40S6*czE3NTM4OTYxMDYkbzQkZzEkdDE3NTM4OTYxNjIkajQkbDAkaDA.', 
                      'https://images.pexels.com/photos/33217150/pexels-photo-33217150.jpeg?_gl=1*1vsr0ky*_ga*NTk1MjM5NjEuMTc0NDkzMDE5NQ..*_ga_8JE65Q40S6*czE3NTM4OTYxMDYkbzQkZzEkdDE3NTM4OTYyMTkkajQyJGwwJGgw',
                      'https://cdn.pixabay.com/video/2024/06/01/214765_large.mp4'], // change to widget.project.mediaUrls if available
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: _ProjectBudget(project: widget.project),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _lancerCollecte,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text(
                'Lancer la collecte',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
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
          userId: project.author.id,
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
                    style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                  const SizedBox(width: 8.0),
                  const Icon(Icons.public, size: 12.0, color: Colors.grey),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_horiz, color: Colors.grey),
        ),
      ],
    );
  }
}

class _ProjectBudget extends StatefulWidget {
  final Project project;
  const _ProjectBudget({required this.project});

  @override
  State<_ProjectBudget> createState() => _ProjectBudgetState();
}

class _ProjectBudgetState extends State<_ProjectBudget> {
  double collected = 0.0;
  double target = 0.0;

  @override
  void initState() {
    super.initState();
    collected = widget.project.totalCollected?.toDouble() ?? 0.0;
    target = widget.project.collectGoal.toDouble();
  }

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
    final progress = (collected / target).clamp(0.0, 1.0);
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
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
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
                  '🎯 ${formatAmount(target)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
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
