import 'package:cached_network_image/cached_network_image.dart';
import 'package:crowfunding_project/domain/entities/post.dart';
import 'package:crowfunding_project/ui/features/home/component/profile_avatar.dart';
import 'package:flutter/material.dart';

class PostContainer extends StatelessWidget {
  final Post post;
  const PostContainer({super.key, required this.post});

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
                _PostHeader(post: post),
                const SizedBox(height: 4.0),
                Text(
                  post.content != null ? post.content! : 'No content available',
                ),
                SizedBox(height: 6.0),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CachedNetworkImage(
              imageUrl: 'https://images.pexels.com/photos/12199063/pexels-photo-12199063.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200.0,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ],
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final Post post;
  const _PostHeader({required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(userProfileImageUrl: 'https://images.pexels.com/photos/6646918/pexels-photo-6646918.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.author.name != null ? post.author.name! : 'Unknown Author',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    post.createdAt.toString(),
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  const Icon(
                    Icons.public,
                    size: 12.0,
                    color: Colors.grey,
                  ),
                ],
              )
            ],
          ),
          ),
          IconButton(
            onPressed: () => print('More options'), 
            icon: const Icon(Icons.more_horiz, color: Colors.grey),
            )
      ],
    );
  }
}
