import 'dart:ui';

import 'package:digital_government/core/constants/colors/colors.dart';
import 'package:digital_government/modules/authentication/controller/login_controller.dart';
import 'package:get/get.dart';

class AuthMainController extends GetxController {
  bool loginTapped = true;
  bool signupTapped = false;
  Color loginTextColor = AppColors.darkBlue;
  Color signupTextColor = AppColors.blueAccent;
  Color loginContainerColor = AppColors.white;
  Color signupContainerColor = AppColors.transparent;

  void selectLogin() {
    loginTapped = true;
    signupTapped = false;
    loginTextColor = AppColors.darkBlue;
    signupTextColor = AppColors.blueAccent;
    loginContainerColor = AppColors.white;
    signupContainerColor = AppColors.transparent;
    update();
  }

  void selectSignup() {
    signupTapped = true;
    loginTapped = false;
    loginTextColor = AppColors.blueAccent;
    signupTextColor = AppColors.darkBlue;
    loginContainerColor = AppColors.transparent;
    signupContainerColor = AppColors.white;
    update();
  }

}
