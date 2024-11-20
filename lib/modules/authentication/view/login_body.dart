import 'package:digital_government/core/components/components.dart';
import 'package:digital_government/core/constants/colors/colors.dart';
import 'package:digital_government/core/constants/images/images.dart';
import 'package:digital_government/core/texts/words.dart';
import 'package:digital_government/core/utils/dimensions.dart';
import 'package:digital_government/core/validator/app_validator.dart';
import 'package:digital_government/modules/authentication/controller/login_controller.dart';
import 'package:digital_government/modules/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginBody extends GetView<LoginController> {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return GetBuilder<LoginController>(
      builder: (_) {
        return Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: ScreenDimensions.heightPercentage(context, 30),
                child: SvgPicture.asset(AppImages.welcome),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenDimensions.heightPercentage(context, 1),
                    horizontal: ScreenDimensions.widthPercentage(context, 3)),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: AppText.subtitleBold(AppWord.welcome),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenDimensions.heightPercentage(context, 1),
                    horizontal: ScreenDimensions.widthPercentage(context, 6)),
                child: AppTextFormField(
                  controller: controller.nationalNumberController,
                  prefixImage: AppImages.nationalNumber,
                  labelText: AppWord.nationalNumber,
                  keyboardType: TextInputType.number,
                  validator: (value){
                     return AppValidator().nationalNumberValidator(value);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenDimensions.heightPercentage(context, 1),
                    horizontal: ScreenDimensions.widthPercentage(context, 6)),
                child: AppTextFormField(
                  controller: controller.passwordController,
                  prefixImage: AppImages.lock,
                  labelText: AppWord.password,
                  keyboardType: TextInputType.visiblePassword,
                  suffixImage: AppImages.eye,
                  onSuffixTap: controller.hidePassword,
                  obscureText: controller.isHided,
                  maxLines: 1,
                  validator: (value){
                    return AppValidator().passwordValidator(value);
                  },
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: ScreenDimensions.heightPercentage(context, 22)),
                child: AppButton(
                    buttonName: AppWord.login,
                    buttonLogo: controller.isLoading?CircularProgressIndicator(color: AppColors.white):null,
                    onTap: (){
                      if(!(controller.formKey.currentState!.validate())){
                        return;
                      }else{
                        controller.login();
                      }
                }),
              ),
            ],
          ),
        );
      }
    );
  }
}

