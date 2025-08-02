import 'package:crowfunding_project/core/constants/constants.dart';
import 'package:crowfunding_project/core/controllers/session_manager.dart';
import 'package:crowfunding_project/utils/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text(
            "N'Zassa Fund",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Obx(() {
                bool isLogged = Get.find<SessionManager>().isLoggedIn;
                  return CircleAvatar(
                    backgroundImage: NetworkImage(
                      isLogged
                      ? 'https://images.pexels.com/photos/6646918/pexels-photo-6646918.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
                      : 'https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_1280.png',
                            ),
                          );
                }
              ),
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: Constants.getHomeScreenTabs(_tabController.index),
            controller: _tabController,
            onTap: (index) {
              setState(() {});
            },
          ),
        ),
        drawer: CustomDrawer(),
        body: TabBarView(
          controller: _tabController,
          children: Constants.screens,
        ),
      ),
    );
  }
}
