import 'package:crowfunding_project/navigation/base_controller.dart';
import 'package:crowfunding_project/navigation/bottom_navigation_bar.dart';
import 'package:crowfunding_project/navigation/nested_nav/collect_creation_nav.dart';
import 'package:crowfunding_project/navigation/nested_nav/home_nav.dart';
import 'package:crowfunding_project/navigation/nested_nav/search_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {

  @override
  void initState(){
    super.initState();
    FlutterNativeSplash.remove();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: BaseController.to.currentIndex.value,
          children: [
            HomeNav(),
            CollectCreationNav(),
            SearchNav(),
          ],
        )
        ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

