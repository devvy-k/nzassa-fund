import 'package:crowfunding_project/core/di/global_bindings.dart';
import 'package:crowfunding_project/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  GlobalBindings().dependencies();
  await dotenv.load();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "N'Zassa Fund",
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      getPages: AppRoutes.routes,
    ),
  );
}
