import 'package:crowfunding_project/core/domain/entities/project.dart';
import 'package:crowfunding_project/ui/features/projects/component/profile_avatar.dart';
import 'package:flutter/material.dart';

class ProjectHeader extends StatelessWidget {
  final Project project;
  const ProjectHeader({super.key, required this.project});

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