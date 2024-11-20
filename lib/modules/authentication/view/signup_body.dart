import 'package:delayed_display/delayed_display.dart';
import 'package:digital_government/core/components/components.dart';
import 'package:digital_government/core/constants/colors/colors.dart';
import 'package:digital_government/core/constants/images/images.dart';
import 'package:digital_government/core/texts/words.dart';
import 'package:digital_government/core/utils/dimensions.dart';
import 'package:digital_government/core/validator/app_validator.dart';
import 'package:digital_government/modules/authentication/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupBody extends GetView<SignupController> {
  const SignupBody({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());
    return GetBuilder<SignupController>(builder: (_) {
      return SizedBox(
        width: ScreenDimensions.screenWidth(context),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenDimensions.widthPercentage(context, 3),
                    vertical: ScreenDimensions.heightPercentage(context, 1)),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: AppText.subtitleBold(AppWord.welcome),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenDimensions.widthPercentage(context, 6),
                  vertical: ScreenDimensions.heightPercentage(context, 1),
                ),
                child: AppTextFormField(
                  controller: controller.nationalNumberController,
                  prefixImage: AppImages.nationalNumber,
                  labelText: AppWord.nationalNumber,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    return AppValidator().nationalNumberValidator(value);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenDimensions.widthPercentage(context, 6),
                  vertical: ScreenDimensions.heightPercentage(context, 1),
                ),
                child: AppTextFormField(
                  controller: controller.phoneNumberController,
                  prefixImage: AppImages.phone,
                  labelText: AppWord.phoneNumber,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    return AppValidator().phoneNumberValidator(value);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenDimensions.widthPercentage(context, 6),
                  vertical: ScreenDimensions.heightPercentage(context, 1),
                ),
                child: AppTextFormField(
                  controller: controller.passwordController,
                  prefixImage: AppImages.lock,
                  labelText: AppWord.password,
                  suffixImage: AppImages.eye,
                  onSuffixTap: controller.hidePassword,
                  obscureText: controller.isHided,
                  maxLines: 1,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    return AppValidator().passwordValidator(value);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenDimensions.widthPercentage(context, 6),
                  vertical: ScreenDimensions.heightPercentage(context, 1),
                ),
                child: AppTextFormField(
                  controller: controller.accountNumberController,
                  prefixImage: AppImages.accountNumber,
                  labelText: AppWord.accountNumber,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    return AppValidator().accountNumberValidator(value);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenDimensions.widthPercentage(context, 3),
                    vertical: ScreenDimensions.heightPercentage(context, 1)),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: AppText.subtitleBold(AppWord.uploadPersonalPhoto),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenDimensions.widthPercentage(context, 3),
                    vertical: ScreenDimensions.heightPercentage(context, 1)),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: AppText.smallBold(
                    AppWord.theImageMustBeClear,
                    textAlign: TextAlign.right,
                    maxLines: 3,
                    fontColor: AppColors.red,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenDimensions.widthPercentage(context, 3),
                    vertical: ScreenDimensions.heightPercentage(context, 1)),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: controller.picked ? () {} : controller.pickImage,
                        child: Container(
                          width: ScreenDimensions.widthPercentage(context, 12),
                          height: ScreenDimensions.heightPercentage(context, 6),
                          decoration: BoxDecoration(
                              color: AppColors.blueAccent,
                              borderRadius: BorderRadius.circular(
                                  ScreenDimensions.radius(context, 1))),
                          alignment: Alignment.center,
                          child: Icon(
                            controller.picked ? Icons.done_all : Icons.add,
                            color: AppColors.white,
                            size: ScreenDimensions.heightPercentage(context, 3),
                          ),
                        ),
                      ),
                      controller.picked
                          ? DelayedDisplay(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        ScreenDimensions.widthPercentage(
                                            context, 3)),
                                child: GestureDetector(
                                  onTap: controller.deleteImage,
                                  child: Container(
                                    width: ScreenDimensions.widthPercentage(
                                        context, 12),
                                    height: ScreenDimensions.heightPercentage(
                                        context, 6),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.red),
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.delete_outline,
                                      color: AppColors.red,
                                      size: ScreenDimensions.heightPercentage(
                                          context, 3),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenDimensions.heightPercentage(context, 9)),
                child: Align(
                  alignment: Alignment.center,
                  child: AppButton(
                    buttonName: AppWord.signup,
                    buttonLogo: controller.isLoading?CircularProgressIndicator(color: AppColors.white,):null,
                    onTap: () {
                      if (!(controller.formKey.currentState!.validate()) ||
                          controller.image == null) {
                        return;
                      } else {
                        controller.signup();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
