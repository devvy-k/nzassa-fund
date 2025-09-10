import 'package:crowfunding_project/ui/features/projects/component/profile_avatar.dart';
import 'package:crowfunding_project/utils/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            color: CustomTheme.orangePrimary,
            child: 
                Row(
                  children: [
                    ProfileAvatar(
                      userProfileImageUrl: 'https://images.pexels.com/photos/6646918/pexels-photo-6646918.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                      userId: 'user123', // Replace with actual user ID
                      size: 50.0,
                    ),
                  ],
                ),
          ),
          const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Text('We care', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8),
                      Icon(Icons.verified, color: Colors.blue, size: 18),
                      SizedBox(width: 4),
                      Text('Get Verified', style: TextStyle(color: Colors.blue, fontSize: 12)),
                    ],
                  ),
                ),
          const SizedBox(height: 4),
          // bio if association
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const Text('We care est une association crée dans le but de soutenir les mères sans domicile.'),
          ),
          const SizedBox(height: 15),
          const Divider(thickness: 0.5),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const Row(
              children: [
                Icon(Icons.family_restroom_outlined, size: 16, color: CustomTheme.blueAccent,),
                SizedBox(width: 4),
                Text("Membre de la famille N'Zassa"),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const Row(
              children: [
                Icon(Icons.volunteer_activism_outlined, size: 16, color: CustomTheme.blueAccent,),
                SizedBox(width: 4),
                Text('0 collecte(s) soutenues'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Divider(thickness: 0.5),
          const SizedBox(height: 8,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('97 Following'),
              SizedBox(width: 12),
              Text('1 Follower'),
            ],
          ),
          const SizedBox(height: 20),
          const TabBarSection(),
          const Expanded(
            child: Center(
              child: Text('No content to display.', style: TextStyle(color: Colors.grey)),
            ),
          ),
        ],
      ),
    );
  }
}

class TabBarSection extends StatelessWidget {
  const TabBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: const [
          TabBar(
            indicatorColor: Colors.blue,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Collectes lancées'),
              Tab(text: 'Réalisations'),
            ],
          ),
        ],
      ),
    );
  }
}
