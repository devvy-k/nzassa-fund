import 'package:crowfunding_project/core/di/global_bindings.dart';
import 'package:crowfunding_project/navigation/routes.dart';
import 'package:crowfunding_project/utils/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsBinding widegetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widegetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  GlobalBindings().dependencies();
  await dotenv.load(fileName: ".env");
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "N'Zassa Fund",
      themeMode: ThemeMode.system,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      initialRoute: '/',
      getPages: AppRoutes.routes,
    ),
  );
}
