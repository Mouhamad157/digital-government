import 'package:digital_government/core/firebase/database.dart';
import 'package:digital_government/core/storage_handler/storage_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../home/view/home_screen.dart';

class LoginController extends GetxController {
  late GlobalKey<FormState> formKey;
  FirebaseDataSource firebaseDataSource = Get.find() ;
  late TextEditingController nationalNumberController;
  late TextEditingController passwordController;
  bool isHided = true;
  bool isLoading = false;

  void hidePassword() {
    isHided = !isHided;
    update();
  }

  void login() async {
    isLoading = true;
    update();
    await firebaseDataSource .login(
        privateNumber: int.parse(nationalNumberController.text),
        password: passwordController.text).then((value) async {
      if (value) {
        await StorageHandler().setUserId(nationalNumberController.text);
        print(StorageHandler().userId);
        isLoading = false;
        Get.to(const HomeScreen(),transition: Transition.fadeIn,duration: const Duration(milliseconds: 700));
        update();
      }else{
        print('the value is: $value');
        isLoading = false;
        Get.snackbar('ملاحظة', 'رقم وطني أو كلمة مرور خاطئة');
        update();
      }
    });
  }

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    nationalNumberController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    nationalNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}