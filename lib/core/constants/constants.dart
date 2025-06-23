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

  static List<Map<String, String>> onbardScreen = [
    {
      'title': 'Bienvenue dans la famille N\'Zassa Fund',
      'description': 'Decouvrez comment nous pouvons ensemble soutenir les projets locaux.',
      'image': 'assets/images/onboarding1.png',
    },
    {
      'title': 'Des initiatives locales par des associations locales',
      'description': 'Aidez les associations locales à réaliser leurs projets.',
      'image': 'assets/images/onboarding2.png',
    },
    {
      'title': 'C\'est ensemble que nous y arriverons',
      'description': 'Rejoignez-nous pour faire la différence dans votre communauté.',
      'image': 'assets/images/onboarding3.png',
    },
  ];
}
  
