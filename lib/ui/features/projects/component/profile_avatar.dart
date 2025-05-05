import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.userProfileImageUrl
    });

  final String userProfileImageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 20.0,
          backgroundColor: Colors.blue,
          child: CircleAvatar(
            radius: 17.0,
            backgroundColor: Colors.grey[200],
            backgroundImage: CachedNetworkImageProvider(userProfileImageUrl),
          ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 15.0,
              width: 15.0,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
            ),
            )
      ],
    );
  }
}
