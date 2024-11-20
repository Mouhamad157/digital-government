import 'package:digital_government/core/firebase/database.dart';
import 'package:digital_government/core/general_models/civilian_model.dart';
import 'package:digital_government/core/storage_handler/storage_handler.dart';
import 'package:digital_government/modules/home/view/home_body_view.dart';
import 'package:digital_government/modules/home/view/my_transactions_view.dart';
import 'package:digital_government/modules/home/view/profile_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  int currentIndex = 0;
  FirebaseDataSource firebaseStorage = Get.find();
  Civilian? civilianDetails ;
  bool isLoading = true;
  List<Widget> screens = [
    const HomeBody(),
    const MyTransactionsScreen(),
    const ProfileScreen()
  ];

  void getCivilianDetails() async {
    isLoading = true;
    update();
    print(StorageHandler().userId);
    await firebaseStorage
        .getCivilianByPrivateNumber(
            privateNumber: int.parse(StorageHandler().userId))
        .then((value) {
          isLoading = false;
          civilianDetails = value!;
          update();
    });
  }

  @override
  void onInit() {
    getCivilianDetails();
    super.onInit();
  }
}
