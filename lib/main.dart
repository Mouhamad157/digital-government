import 'package:digital_government/core/firebase/database.dart';
import 'package:digital_government/core/firebase/firebase_init.dart';
import 'package:digital_government/core/storage_handler/storage_handler.dart';
import 'package:digital_government/modules/home/controller/home_body_controller.dart';
import 'package:digital_government/modules/home/controller/home_controller.dart';
import 'package:digital_government/modules/splash_screen/view/splash_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'modules/home/controller/profile_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseConfiguration.initFireBase();
  await StorageHandler.init();
  // await StorageHandler().removeUserId();
  // Get.log('user id is : ${StorageHandler().userId}');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onInit:onInit ,
      home: const SplashScreen(),
    );
  }
  onInit () {
    Get.put(FirebaseDataSource());
    Get.put(HomeBodyController());
    Get.put(HomeController());
    Get.put(ProfileController());
  }
}
