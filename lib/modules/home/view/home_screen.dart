import 'package:digital_government/core/constants/colors/colors.dart';
import 'package:digital_government/core/constants/images/images.dart';
import 'package:digital_government/core/storage_handler/storage_handler.dart';
import 'package:digital_government/core/texts/words.dart';
import 'package:digital_government/core/utils/app_fonts.dart';
import 'package:digital_government/core/utils/dimensions.dart';
import 'package:digital_government/modules/home/controller/home_controller.dart';
import 'package:digital_government/modules/notifications/view/notification_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../core/components/components.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return SafeArea(
      child: GetBuilder<HomeController>(
          initState: (state) {
            controller.getCivilianDetails();
          },
          builder: (_) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            bottomNavigationBar: Container(
              height: ScreenDimensions.heightPercentage(context, 4),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.blue),
                  borderRadius:
                      BorderRadius.circular(ScreenDimensions.radius(context, 5))),
              margin: EdgeInsets.symmetric(
                  horizontal: ScreenDimensions.widthPercentage(context, 10),
                  vertical: ScreenDimensions.heightPercentage(context, 1)),
              child: SalomonBottomBar(
                backgroundColor: AppColors.transparent,
                currentIndex: controller.currentIndex,
                onTap: (currentIndex) {
                  controller.currentIndex = currentIndex;
                  controller.update();
                },
                itemPadding: EdgeInsets.symmetric(
                    horizontal: ScreenDimensions.widthPercentage(context, 5)),
                items: [
                  SalomonBottomBarItem(
                      icon: Icon(
                        Icons.home,
                        color: AppColors.blue,
                        size: ScreenDimensions.heightPercentage(context, 2),
                      ),
                      title: AppText(
                        AppWord.home,
                        style: TextStyle(
                            color: AppColors.blue,
                            fontSize: AppFonts.smallTitleFont(context) - 4),
                      )),
                  SalomonBottomBarItem(
                      icon: Icon(
                        Icons.text_snippet,
                        color: AppColors.blue,
                        size: ScreenDimensions.heightPercentage(context, 2),
                      ),
                      title: AppText(
                        AppWord.myTransactions,
                        style: TextStyle(
                            color: AppColors.blue,
                            fontSize: AppFonts.smallTitleFont(context) - 4),
                      )),
                  SalomonBottomBarItem(
                      icon: Icon(
                        Icons.person_pin,
                        color: AppColors.blue,
                        size: ScreenDimensions.heightPercentage(context, 2),
                      ),
                      title: AppText(
                        AppWord.myProfile,
                        style: TextStyle(
                            color: AppColors.blue,
                            fontSize: AppFonts.smallTitleFont(context) - 4),
                      )),
                ],
              ),
            ),
            appBar: AppBar(
              leadingWidth: ScreenDimensions.widthPercentage(context, 80),
              actions: [
                Padding(
                  padding: EdgeInsets.all(
                      ScreenDimensions.widthPercentage(context, 2)),
                  child: GestureDetector(
                    onTap: (){
                      Get.to(const NotificationScreen(),transition: Transition.zoom,duration: const Duration(milliseconds: 700));
                    },
                      child: Icon(
                    Icons.notifications_active,
                    color: AppColors.darkBlue,
                    size: ScreenDimensions.heightPercentage(context, 3),
                  )),
                )
              ],
              leading: Padding(
                padding:  EdgeInsets.all(ScreenDimensions.widthPercentage(context, 2)),
                child: AppText.subtitleBold(AppWord.welcomeToOurApp,
                  maxLines: 1,
                  fontColor: AppColors.darkBlue,),
              ),
            ),
            body: controller.isLoading?Center(child: CircularProgressIndicator(color: AppColors.darkBlue,)):SizedBox(
              height: ScreenDimensions.screenHeight(context),
              width: ScreenDimensions.screenWidth(context),
              child: Column(
                children: [
                  controller.currentIndex!=2
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    SizedBox(
                        width: ScreenDimensions.widthPercentage(context, 60),
                        child: Column(
                          children: [
                            Padding(
                              padding:  EdgeInsets.symmetric(vertical: ScreenDimensions.heightPercentage(context, 1),horizontal: ScreenDimensions.widthPercentage(context, 2)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText.small(AppWord.nationalNumber,fontColor: AppColors.darkBlue,),
                                  AppText.small(StorageHandler().userId,fontColor: AppColors.darkBlue,),
                                ],
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(vertical: ScreenDimensions.heightPercentage(context, 1),horizontal: ScreenDimensions.widthPercentage(context, 2)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText.small(AppWord.militarySituation,fontColor: AppColors.darkBlue,),
                                  SizedBox(
                                      width: ScreenDimensions.widthPercentage(context, 21),
                                      child: AppText.small(controller.civilianDetails!.militaryStatus,fontColor: AppColors.darkBlue,textAlign: TextAlign.center,)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    SizedBox(
                      width: ScreenDimensions.widthPercentage(context, 30),
                      child: Image.asset(AppImages.hello,filterQuality: FilterQuality.high,fit: BoxFit.cover),
                    ),
                  ],)
                      : const SizedBox.shrink(),
                  controller.screens[controller.currentIndex],
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
