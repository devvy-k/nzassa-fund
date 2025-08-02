import 'package:crowfunding_project/core/controllers/session_manager.dart';
import 'package:crowfunding_project/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = Get.find<AuthService>();

    return Drawer(
      child: Obx(() {
         bool isLogged = Get.find<SessionManager>().isLoggedIn;
          return isLogged
          ? ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: isLogged
                          ? NetworkImage('https://images.pexels.com/photos/6646918/pexels-photo-6646918.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1')
                          : NetworkImage('https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_1280.png'),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      Get.find<SessionManager>().user!.name,
                      style: const TextStyle( fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.dashboard),
                title: const Text('Tableau de bord'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profil'),
                onTap: () => Get.toNamed('/profile'),
              ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Déconnexion'),
                  onTap: () {
                    _authService.signOut();
                    Get.toNamed('/');
                  },
                ),
            ],
          )
          : ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_1280.png')
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Bienvenue',
                      style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.login),
                title: const Text('Connexion'),
                onTap: () => Get.toNamed('/signin'),
              ),
              ListTile(
                leading: const Icon(Icons.app_registration),
                title: const Text('Inscription'),
                onTap: () => Get.toNamed('/role-selection'),
              ),
            ],
          );
        }
      ),
    );
  }
}
