import 'package:digital_government/core/constants/images/images.dart';
import 'package:digital_government/core/storage_handler/storage_handler.dart';
import 'package:digital_government/core/utils/app_network_image.dart';
import 'package:digital_government/modules/authentication/view/authentication_main_screen.dart';
import 'package:digital_government/modules/home/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/components/components.dart';
import '../../../core/constants/colors/colors.dart';
import '../../../core/texts/words.dart';
import '../../../core/utils/dimensions.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      initState: (state) {
        controller.getProfile();
      },
      builder: (_) {
        return controller.isLoading?Center(child: CircularProgressIndicator(color: AppColors.darkBlue,)):Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      right: ScreenDimensions.widthPercentage(context, 4),
                      bottom: ScreenDimensions.heightPercentage(context, 1)),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: ScreenDimensions.widthPercentage(context, 30),
                      height: ScreenDimensions.heightPercentage(context, 4),
                      decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(
                            ScreenDimensions.radius(context, 1)),
                        border: Border.all(color: AppColors.blueAccent),
                      ),
                      alignment: Alignment.center,
                      child: AppText.smallBold(
                        AppWord.myProfile,
                        fontColor: AppColors.darkBlue,
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  AppImages.hello,
                  filterQuality: FilterQuality.high,
                  width: ScreenDimensions.widthPercentage(context, 30),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.darkBlue,width: ScreenDimensions.widthPercentage(context, 0.5)),
                shape: BoxShape.circle
              ),
              child: CircleAvatar(
                radius: ScreenDimensions.radius(context, 10),
                backgroundColor: AppColors.white,
                backgroundImage: NetworkImage(controller.soliderModel!.image,),

              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: ScreenDimensions.widthPercentage(context, 30),
                    child: AppText.smallBold(AppWord.nationalNumber,fontColor: AppColors.darkBlue,textAlign: TextAlign.right,),
                  ),
                  SizedBox(
                    width: ScreenDimensions.widthPercentage(context, 40),
                    child: AppText.smallBold(StorageHandler().userId,fontColor: AppColors.darkBlue,textAlign: TextAlign.center,),
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(bottom: ScreenDimensions.heightPercentage(context, 2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: ScreenDimensions.widthPercentage(context, 30),
                    child: AppText.smallBold(AppWord.militarySituation,fontColor: AppColors.darkBlue,textAlign: TextAlign.right,),
                  ),
                  SizedBox(
                    width: ScreenDimensions.widthPercentage(context, 40),
                    child: AppText.smallBold(controller.homeController.civilianDetails!.militaryStatus,fontColor: AppColors.darkBlue,textAlign: TextAlign.center,),
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(bottom: ScreenDimensions.heightPercentage(context, 2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: ScreenDimensions.widthPercentage(context, 30),
                    child: AppText.smallBold(AppWord.militaryNumber,fontColor: AppColors.darkBlue,textAlign: TextAlign.right,),
                  ),
                  SizedBox(
                    width: ScreenDimensions.widthPercentage(context, 40),
                    child: AppText.smallBold(controller.soliderModel!.militaryNumber.toString(),fontColor: AppColors.darkBlue,textAlign: TextAlign.center,),
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(bottom: ScreenDimensions.heightPercentage(context, 2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: ScreenDimensions.widthPercentage(context, 30),
                    child: AppText.smallBold(AppWord.fullName,fontColor: AppColors.darkBlue,textAlign: TextAlign.right,),
                  ),
                  SizedBox(
                    width: ScreenDimensions.widthPercentage(context, 40),
                    child: AppText.smallBold('${controller.homeController.civilianDetails!.name} ${controller.homeController.civilianDetails!.familyName}',fontColor: AppColors.darkBlue,textAlign: TextAlign.center,),
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(bottom: ScreenDimensions.heightPercentage(context, 2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: ScreenDimensions.widthPercentage(context, 30),
                    child: AppText.smallBold(AppWord.accountNumber,fontColor: AppColors.darkBlue,textAlign: TextAlign.right,),
                  ),
                  SizedBox(
                    width: ScreenDimensions.widthPercentage(context, 40),
                    child: AppText.smallBold(controller.soliderModel!.accountNumber.toString(),fontColor: AppColors.darkBlue,textAlign: TextAlign.center,),
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: ScreenDimensions.heightPercentage(context, 8)),
              child: AppButton(
                  buttonName: AppWord.logout,
                onTap: (){
                    StorageHandler().removeUserId();
                    Get.offAll(const AuthMain(),transition: Transition.fadeIn,duration: const Duration(milliseconds: 700));
                },
              ),
            ),
          ],
        );
      }
    );
  }
}
