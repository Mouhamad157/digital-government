import 'dart:io';

import 'package:digital_government/core/general_models/civilian_model.dart';
import 'package:digital_government/core/storage_handler/storage_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/firebase/database.dart';
import '../../../core/utils/image_handler.dart';
import '../../home/view/home_screen.dart';

class SignupController extends GetxController {
  late GlobalKey<FormState> formKey;
  FirebaseDataSource firebaseDataSource = Get.find();

  late TextEditingController nationalNumberController;
  late TextEditingController phoneNumberController;
  late TextEditingController passwordController;
  late TextEditingController accountNumberController;
  late TextEditingController fullNameController;
  bool isHided = true;
  bool picked = false;
  bool isLoading = false;
  List<File>? image;
  Civilian? civilian;

  void pickImage() async {
    ImageHandler.pickImage().then((value) {
      if (value != null) {
        image = [File(value)];
        picked = true;
        update();
        return;
      }
      picked = false;
      update();
      return;
    });
  }

  void deleteImage() {
    picked = false;
    image!.clear();
    update();
  }

  void hidePassword() {
    isHided = !isHided;
    update();
  }

  void signup() async {
    isLoading = true;
    update();
     await firebaseDataSource.getCivilianByPrivateNumber(
        privateNumber: int.parse(nationalNumberController.text)).then((value) {
          civilian = value;
          print(value!.militaryNumber);
     });
    print(nationalNumberController.text);
    await firebaseDataSource
        .signup(
      privateNumber: int.parse(nationalNumberController.text),
      phoneNumber: phoneNumberController.text,
      password: passwordController.text,
      accountNumber: accountNumberController.text,
      image: image!.first,
      militaryNumber: civilian!.militaryNumber!,
    )
        .then((value) {
      if (value == 'done') {
        isLoading = false;
        StorageHandler().setUserId(nationalNumberController.text);
        Get.to(const HomeScreen(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 700));

        ///TODO : success state
        Get.log(value);
        update();
      } else {
        isLoading = false;

        ///TODO : error state
        Get.log(value);
        Get.snackbar('', value);
        update();
      }
    });
  }

  @override
  Future<void> onInit() async {
    formKey = GlobalKey<FormState>();
    nationalNumberController = TextEditingController();
    passwordController = TextEditingController();
    phoneNumberController = TextEditingController();
    accountNumberController = TextEditingController();
    fullNameController = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    nationalNumberController.dispose();
    passwordController.dispose();
    accountNumberController.dispose();
    phoneNumberController.dispose();
    fullNameController.dispose();
    super.dispose();
  }
}
