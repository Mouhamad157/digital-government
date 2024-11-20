import 'package:digital_government/core/texts/words.dart';
import 'package:digital_government/core/utils/app_fonts.dart';
import 'package:digital_government/core/utils/dimensions.dart';
import 'package:digital_government/modules/splash_screen/controller/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delayed_display/delayed_display.dart';
import '../../../core/constants/colors/colors.dart';
import '../../../core/constants/images/images.dart';

class SplashScreen extends GetView<SplashScreenController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController());
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<SplashScreenController>(builder: (_) {
          return Container(
            width: ScreenDimensions.screenWidth(context),
            height: ScreenDimensions.screenHeight(context),
            color: AppColors.darkBlue,
            child: Column(
              children: [
                const Spacer(),
                DelayedDisplay(
                    delay: const Duration(milliseconds: 1500),
                    slidingBeginOffset: const Offset(0,5),
                    child: CircleAvatar(radius: ScreenDimensions.radius(context, 6))),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   DelayedDisplay(
                     delay: const Duration(milliseconds: 1000),
                      slidingBeginOffset: const Offset(-5,0),
                      child: SizedBox(
                          height: ScreenDimensions.heightPercentage(context, 10),
                          child: Image.asset(AppImages.wafaLoge)),
                    ),
                    DelayedDisplay(
                      delay: const Duration(milliseconds: 500),
                      slidingBeginOffset: const Offset(0,1),
                      child: Text(
                        AppWord.fundedByWafa,
                        style: TextStyle(
                          fontSize: AppFonts.subTitleFont(context),
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black54,
                              blurRadius: 15,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
