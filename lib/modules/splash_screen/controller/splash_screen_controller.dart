import 'package:digital_government/core/storage_handler/storage_handler.dart';
import 'package:digital_government/modules/authentication/view/authentication_main_screen.dart';
import 'package:digital_government/modules/home/view/home_screen.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {

  @override
  void onInit() {
    Future.delayed(const Duration(milliseconds: 2500)).then((value) => Get.offAll(
        StorageHandler().hasUserId?const HomeScreen():const AuthMain(),
        transition: Transition.fadeIn ,
        duration: const Duration(milliseconds: 700),),);
    super.onInit();
  }
}
