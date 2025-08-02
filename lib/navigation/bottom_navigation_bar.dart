import 'package:crowfunding_project/navigation/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
      NavigationBar(
        indicatorColor: Theme.of(context).primaryColor,
        elevation: 10,
        selectedIndex: BaseController.to.currentIndex.value,
        onDestinationSelected: (value) => BaseController.to.changeIndex(value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_filled),
            selectedIcon: Icon(Icons.home),
            label: 'Projets',
          ),
          NavigationDestination(
            icon: Icon(Icons.volunteer_activism_outlined),
            selectedIcon: Icon(Icons.volunteer_activism),
            label: 'Collecte',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Recherche',
          ),
        ],
      )
    );
  }
}
