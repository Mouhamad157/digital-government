import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class FirebaseConfiguration {
  static Future initFireBase() async {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyCbGNHOTACixm3yVurOuPRyunL1_M7s9IE',
      appId: '1:173015570961:android:87260aa421755cbb9b2fb0',
      messagingSenderId: '173015570961',
      projectId: 'digital-transformation-e0e8f',
      storageBucket: 'digital-transformation-e0e8f.appspot.com',
    )).then((value) async {
      Get.log("Firebase init successfully");
      Future.wait([
        _initStorage(),
        _subscribe(),
        _listen(),
      ]);
      // await _subscribe();
      // await _listen();
    });
  }

  static Future _subscribe() async {
    await FirebaseMessaging.instance.isSupported().then((value) {
      Get.log(value.toString());
    });

    await FirebaseMessaging.instance
        .requestPermission(
            announcement: true,
            carPlay: true,
            criticalAlert: true,
            provisional: true)
        .then((value) {
      Get.log(value.authorizationStatus.name.toString());
    });

    if (!GetPlatform.isDesktop) {
      await FirebaseMessaging.instance.subscribeToTopic('test').then((value) {
        Get.log('subscribeToTopic : test');
      });
    }
  }

  static Future _listen() async {
    Get.log('listening');
    FirebaseMessaging.onMessage.listen((event) {
      Get.log('\nmessage get : ${event.notification!.title}');
      Get.snackbar(
        event.notification!.title.toString(),
        event.notification!.body.toString(),
        onTap: (e) {},
        duration: const Duration(
          seconds: 5,
        ),
        colorText: SchedulerBinding.instance.window.platformBrightness ==
                Brightness.dark
            ? Colors.white
            : Colors.black,
        backgroundColor: SchedulerBinding.instance.window.platformBrightness ==
                Brightness.dark
            ? Colors.black
            : Colors.white,
      );
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      Get.log('\nmessage get : ${event.notification!.title}');
    });
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      Get.log('\nmessage get : ${message.notification!.title}');
      Get.snackbar(message.notification!.title!, message.notification!.body!);
    });
  }

  static Future _initStorage() async {
    final storage = FirebaseStorage.instance;
  }
}
