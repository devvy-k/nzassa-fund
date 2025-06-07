import 'package:crowfunding_project/ui/features/projects/projects_screen.dart';
import 'package:flutter/material.dart';

class Constants {
  static List<Tab> getHomeScreenTabs(int index) {
    return [
      Tab(
        icon: Icon(
          index == 0 ? Icons.business : Icons.business_outlined,
          color: Colors.blue,
        ),
      ),
      Tab(
        icon: Icon(
          index == 1 ? Icons.favorite : Icons.favorite_outline,
          color: Colors.blue,
        ),
      ),
      Tab(
        icon: Icon(
          index == 2 ? Icons.check_circle : Icons.check_circle_outline,
          color: Colors.blue,
        ),
      ),
    ];
  }

  static List<Widget> screens = [
    ProjectsScreen(),
    Center(child: Text('Favorites')),
    Center(child: Text('Completed')),
  ];
}
