import 'package:cached_network_image/cached_network_image.dart';
import 'package:crowfunding_project/domain/entities/project.dart';
import 'package:crowfunding_project/ui/features/home/component/profile_avatar.dart';
import 'package:flutter/material.dart';

class ProjectContainer extends StatelessWidget {
  final Project project;
  const ProjectContainer({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,
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
                project.author.name != null ? project.author.name! : 'Unknown Author',
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
          onPressed: () => print('More options'),
          icon: const Icon(Icons.more_horiz, color: Colors.grey),
        ),
      ],
    );
  }
}

class _ProjectStats extends StatelessWidget {
  final Project project;
  const _ProjectStats({required this.project});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.thumb_up,
                color: Colors.white,
                size: 10.0,
              ),
            ),
            const SizedBox(width: 4.0),
            Expanded(
              child: Text('100', style: TextStyle(color: Colors.grey[600])),
            ),
            Text('50 comments', style: TextStyle(color: Colors.grey[600])),
          ],
        ),
        const Divider(),
        Row(
          children: [
            _ProjectButton(
              icon: Icon(
                Icons.thumb_up_alt_outlined,
                color: Colors.grey[600],
                size: 16.0,
              ),
              label: 'Like',
              onTap: () => print('Like'),
            ),
            _ProjectButton(
              icon: Icon(
                Icons.comment_outlined,
                color: Colors.grey[600],
                size: 16.0,
              ),
              label: 'Comment',
              onTap: () => print('Comment'),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProjectButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final VoidCallback onTap;

  const _ProjectButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
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
                  label,
                  style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
