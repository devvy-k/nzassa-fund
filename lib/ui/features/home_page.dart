import 'package:crowfunding_project/core/constants/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;

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
        appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Text(
                "N'Zassa Fund",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.2,
                ),
              ),
              centerTitle: false,
              bottom: TabBar(
                tabs: Constants.getHomeScreenTabs(_tabController.index),
                controller: _tabController,
                onTap: (index) {
                  setState(() {});
                },
              ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: Constants.screens,
        )
      ),
    );
  }
}
