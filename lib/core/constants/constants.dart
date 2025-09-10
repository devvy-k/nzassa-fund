import 'package:crowfunding_project/ui/features/projects/completed_project_screen.dart';
import 'package:crowfunding_project/ui/features/projects/projects_screen.dart';
import 'package:crowfunding_project/utils/under_development_screen.dart';
import 'package:flutter/material.dart';

class Constants {
  static List<Tab> getHomeScreenTabs(int index) {
    return [
      Tab(
        icon: Icon(
          index == 0 ? Icons.business : Icons.business_outlined,
          color: Colors.white,
        ),
      ),
      Tab(
        icon: Icon(
          index == 1 ? Icons.favorite : Icons.favorite_outline,
          color: Colors.white,
        ),
      ),
      Tab(
        icon: Icon(
          index == 2 ? Icons.check_circle : Icons.check_circle_outline,
          color: Colors.white,
        ),
      ),
    ];
  }

  static List<Widget> screens = [
    ProjectsScreen(),
    UnderDevelopmentScreen(),
    CompletedProjectScreen(),
  ];

  static List<Map<String, String>> onbardScreen = [
    {
      'title': 'Bienvenue dans la famille N\'Zassa Fund',
      'description': 'Decouvrez comment nous pouvons ensemble soutenir les projets locaux.',
      'background': 'assets/images/onboarding1.jpg',
    },
    {
      'title': 'Des initiatives locales par des associations locales',
      'description': 'Aidez les associations locales à réaliser leurs projets.',
      'background': 'assets/images/onboarding2.jpg',
    },
    {
      'title': 'C\'est ensemble que nous y arriverons',
      'description': 'Rejoignez-nous pour faire la différence dans votre communauté.',
      'background': 'assets/images/onboarding3.jpg',
    },
  ];

  static customShowDialog(BuildContext context, String title, String content, {required Function validateAction, required Function cancelAction, required bool canDismiss} ) {
    showDialog(
      context: context,
      barrierDismissible: canDismiss,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text(content),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey,
              ),
              onPressed: () {
                cancelAction();
              },
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                validateAction();
              },
              child: Text('Confirmer'),
            ),
          ],
        );
      },
    );
  }
}
  
