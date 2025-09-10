
import 'package:crowfunding_project/core/data/models/project_model.dart';

import 'package:crowfunding_project/ui/features/projects/component/project_budget.dart';
import 'package:crowfunding_project/ui/features/projects/component/project_header.dart';
import 'package:crowfunding_project/ui/features/projects/component/project_stats.dart';

import 'package:crowfunding_project/utils/media_pager.dart';

import 'package:flutter/material.dart';


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
                ProjectHeader(project: project),
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
            child: MediaPager(mediaUrls: ['https://images.pexels.com/photos/12199063/pexels-photo-12199063.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'],)
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ProjectBudget(project: project),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ProjectStats(project: project),
          ),
        ],
      ),
    );
  }
}

