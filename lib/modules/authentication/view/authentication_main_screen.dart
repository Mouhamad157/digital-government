import 'package:delayed_display/delayed_display.dart';
import 'package:digital_government/core/constants/colors/colors.dart';
import 'package:digital_government/core/texts/words.dart';
import 'package:digital_government/core/utils/app_fonts.dart';
import 'package:digital_government/core/utils/dimensions.dart';
import 'package:digital_government/modules/authentication/controller/auth_controller.dart';
import 'package:digital_government/modules/authentication/controller/login_controller.dart';
import 'package:digital_government/modules/authentication/view/login_body.dart';
import 'package:digital_government/modules/authentication/view/signup_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/components.dart';

class AuthMain extends GetView<AuthMainController> {
  const AuthMain({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthMainController());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: GetBuilder<AuthMainController>(
              builder: (_) {
                return Column(
                  children: [
                    Container(
                      height: ScreenDimensions.heightPercentage(context, 6),
                      width: ScreenDimensions.widthPercentage(context, 85),
                      decoration: BoxDecoration(
                        color: AppColors.blueAccent.withOpacity(0.4),
                        borderRadius:
                        BorderRadius.circular(
                            ScreenDimensions.radius(context, 1)),
                      ),
                      margin: EdgeInsets.only(
                          top: ScreenDimensions.heightPercentage(context, 4)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: controller.selectLogin,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 10),
                              transformAlignment: Alignment.center,
                              height: ScreenDimensions.heightPercentage(
                                  context, 5),
                              width: ScreenDimensions.widthPercentage(
                                  context, 35),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: controller.loginContainerColor,
                                borderRadius: BorderRadius.circular(
                                    ScreenDimensions.radius(context, 1)),
                              ),
                              child: AppText.subtitleBold(AppWord.login,
                                  fontColor: controller.loginTextColor),
                            ),
                          ),
                          GestureDetector(
                            onTap: controller.selectSignup,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 100),
                              height: ScreenDimensions.heightPercentage(
                                  context, 5),
                              width: ScreenDimensions.widthPercentage(
                                  context, 35),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: controller.signupContainerColor,
                                borderRadius: BorderRadius.circular(
                                    ScreenDimensions.radius(context, 1)),
                              ),
                              child: AppText.subtitleBold(AppWord.signup,
                                  fontColor: controller.signupTextColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedCrossFade(
                      firstChild: const LoginBody(),
                      secondChild: const SignupBody(),
                      crossFadeState: controller.loginTapped?CrossFadeState.showFirst:CrossFadeState.showSecond,
                      duration: const Duration(milliseconds: 300),
                      reverseDuration: const Duration(milliseconds: 300),
                      firstCurve: Curves.fastOutSlowIn,
                    ),
                  ],
                );
              }
          ),
        ),
      ),
    );
  }
}

