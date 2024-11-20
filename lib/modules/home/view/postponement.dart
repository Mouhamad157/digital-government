import 'dart:ui';

import 'package:digital_government/core/components/components.dart';
import 'package:digital_government/core/storage_handler/storage_handler.dart';
import 'package:digital_government/modules/home/controller/postponement_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/constants/colors/colors.dart';
import '../../../core/constants/images/images.dart';
import '../../../core/texts/words.dart';
import '../../../core/utils/dimensions.dart';

class PostponementScreen extends GetView<PostponementController> {
  const PostponementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PostponementController());
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<PostponementController>(
          builder: (_) {
            return Scaffold(
              appBar: AppBar(
                leadingWidth: ScreenDimensions.widthPercentage(context, 80),
                actions: const [BackArrow(),
                ],
                leading: Padding(
                  padding:  EdgeInsets.all(ScreenDimensions.widthPercentage(context, 2)),
                  child: AppText.subtitleBold(AppWord.welcomeToOurApp,
                    maxLines: 1,
                    fontColor: AppColors.darkBlue,),
                ),
              ),
              body: Column(
                children: [
                  Row(
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
                                      child: AppText.small(controller.homeController.civilianDetails!.militaryStatus,fontColor: AppColors.darkBlue,textAlign: TextAlign.center,)),
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
                    ],),
                  Padding(
                    padding: EdgeInsets.only(
                        right: ScreenDimensions.widthPercentage(context, 2),
                        bottom: ScreenDimensions.heightPercentage(context, 1)),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: ScreenDimensions.widthPercentage(context, 30),
                        height: ScreenDimensions.heightPercentage(context, 4),
                        decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius:
                          BorderRadius.circular(ScreenDimensions.radius(context, 1)),
                          border: Border.all(color: AppColors.blueAccent),
                        ),
                        alignment: Alignment.center,
                        child: AppText.smallBold(
                          AppWord.postponement,
                          fontColor: AppColors.darkBlue,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: ScreenDimensions.heightPercentage(context, 10)),
                    child: SizedBox(
                      width: ScreenDimensions.widthPercentage(context, 90),
                      height: ScreenDimensions.heightPercentage(context, 50),
                      child: GridView.builder(
                        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          mainAxisExtent: ScreenDimensions.widthPercentage(context, 25),
                          crossAxisSpacing: ScreenDimensions.widthPercentage(context, 8),
                          mainAxisSpacing: ScreenDimensions.heightPercentage(context, 2),
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap : (){
                            switch (index) {
                              case 0 :
                                {
                                  if(controller.homeController.civilianDetails!.militaryStatus=='backward'){
                                     controller.sendRequest();}
                                  if(controller.homeController.civilianDetails!.militaryStatus=='delayed'){
                                    Get.dialog(
                                        GeneralDialog(
                                          children: [
                                            AppText.subtitleBold(AppWord.sorryYouCantDoThisRequest),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                  ScreenDimensions.heightPercentage(Get.context!, 1)),
                                              child: SvgPicture.asset(
                                                AppImages.wanted,
                                                height: ScreenDimensions.widthPercentage(Get.context!, 40),
                                                width: ScreenDimensions.screenWidth(Get.context!),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                  ScreenDimensions.heightPercentage(Get.context!, 2)),
                                              child: SizedBox(
                                                width: ScreenDimensions.widthPercentage(Get.context!, 60),
                                                child: AppText.smallBold(
                                                  AppWord.delayed,
                                                  maxLines: 3,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        barrierDismissible: true);
                                  }
                                  if(controller.homeController.civilianDetails!.militaryStatus=='wanted'){
                                    Get.dialog(GeneralDialog(
                                          children: [
                                            AppText.subtitleBold(AppWord.sorryYouCantDoThisRequest),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                  ScreenDimensions.heightPercentage(Get.context!, 1)),
                                              child: SvgPicture.asset(
                                                AppImages.wanted,
                                                height: ScreenDimensions.widthPercentage(Get.context!, 40),
                                                width: ScreenDimensions.screenWidth(Get.context!),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                  ScreenDimensions.heightPercentage(Get.context!, 2)),
                                              child: SizedBox(
                                                width: ScreenDimensions.widthPercentage(Get.context!, 60),
                                                child: AppText.smallBold(
                                                  AppWord.youAreWanted,
                                                  maxLines: 3,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ));
                                  }
                                  if(controller.homeController.civilianDetails!.militaryStatus=='exempt'){
                                    Get.dialog(
                                        GeneralDialog(
                                          children: [
                                            AppText.subtitleBold(AppWord.sorryYouCantDoThisRequest),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                  ScreenDimensions.heightPercentage(Get.context!, 1)),
                                              child: SvgPicture.asset(
                                                AppImages.wanted,
                                                height: ScreenDimensions.widthPercentage(Get.context!, 40),
                                                width: ScreenDimensions.screenWidth(Get.context!),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                  ScreenDimensions.heightPercentage(Get.context!, 2)),
                                              child: SizedBox(
                                                width: ScreenDimensions.widthPercentage(Get.context!, 60),
                                                child: AppText.smallBold(
                                                  AppWord.exempt,
                                                  maxLines: 3,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ));
                                  }
                                  if(controller.homeController.civilianDetails!.militaryStatus=='servant'){
                                    Get.dialog(
                                        GeneralDialog(
                                          children: [
                                            AppText.subtitleBold(AppWord.sorryYouCantDoThisRequest),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                  ScreenDimensions.heightPercentage(Get.context!, 1)),
                                              child: SvgPicture.asset(
                                                AppImages.wanted,
                                                height: ScreenDimensions.widthPercentage(Get.context!, 40),
                                                width: ScreenDimensions.screenWidth(Get.context!),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                  ScreenDimensions.heightPercentage(Get.context!, 2)),
                                              child: SizedBox(
                                                width: ScreenDimensions.widthPercentage(Get.context!, 60),
                                                child: AppText.smallBold(
                                                  AppWord.servant,
                                                  maxLines: 3,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ));
                                  }
                                  if(controller.homeController.civilianDetails!.militaryStatus=='non binding'){
                                    Get.dialog(
                                        GeneralDialog(
                                          children: [
                                            AppText.subtitleBold(AppWord.sorryYouCantDoThisRequest),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                  ScreenDimensions.heightPercentage(Get.context!, 1)),
                                              child: SvgPicture.asset(
                                                AppImages.wanted,
                                                height: ScreenDimensions.widthPercentage(Get.context!, 40),
                                                width: ScreenDimensions.screenWidth(Get.context!),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                  ScreenDimensions.heightPercentage(Get.context!, 2)),
                                              child: SizedBox(
                                                width: ScreenDimensions.widthPercentage(Get.context!, 60),
                                                child: AppText.smallBold(
                                                  AppWord.youAreWanted,
                                                  maxLines: 3,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ));
                                  }
                                }
                              case 1 :
                                {Get.dialog( AppDialog(content: AppWord.theETravelWillBeAvailableSoon,));}
                              case 2 :{
                                Get.dialog( AppDialog(content: AppWord.theBreadWinnerWillBeAvailableSoon,));
                              }
                              case 3 :{
                                Get.dialog( AppDialog(content: AppWord.theSingleWillBeAvailableSoon,));
                              }
                              case 4 :{Get.dialog( AppDialog(content: AppWord.theAdministrativeWillBeAvailableSoon,));}
                              case 5 :{Get.dialog( AppDialog(content: AppWord.theExpatriateWillBeAvailableSoon,));}
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(ScreenDimensions.radius(context, 1)),
                              color: controller.itemColor[index],
                              border: index==4? Border.all(color: AppColors.darkBlue):null,
                              boxShadow: [BoxShadow(blurRadius: 3,color: AppColors.grey,offset: const Offset(0,3))]
                            ),
                            child: AppText.smallBold(controller.itemContent[index],fontColor: index<3?AppColors.white:AppColors.darkBlue,maxLines: 2,textAlign: TextAlign.center,),
                          ),
                        );
                      },),
                    ),
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}

