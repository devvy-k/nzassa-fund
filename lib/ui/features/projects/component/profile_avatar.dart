import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, required this.userProfileImageUrl, required this.userId, this.size = 20.0});

  final String userProfileImageUrl;
  final String userId;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.toNamed('/profile', arguments: {'userId': userId, 'userProfileImageUrl': userProfileImageUrl});
      },
        child: CircleAvatar(
          radius: size,
          backgroundColor: Colors.grey[200],
          child: CircleAvatar(
            radius: size - 3,
            backgroundColor: Colors.grey[200],
            backgroundImage: CachedNetworkImageProvider(userProfileImageUrl),
          ),
        ),
    );
  }
}
