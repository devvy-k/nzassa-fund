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
            selectedIcon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.healing_outlined),
            selectedIcon: Icon(Icons.healing, color: Colors.white),
            label: 'Collecte',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search, color: Colors.white),
            label: 'Search',
          ),
        ],
      )
    );
  }
}
