import 'package:digital_government/modules/notifications/controller/notfication_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/components/components.dart';
import '../../../core/constants/colors/colors.dart';
import '../../../core/constants/images/images.dart';
import '../../../core/texts/words.dart';
import '../../../core/utils/dimensions.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationController());
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            leadingWidth: ScreenDimensions.widthPercentage(context, 80),
            leading: Padding(
              padding:
                  EdgeInsets.all(ScreenDimensions.widthPercentage(context, 2)),
              child: AppText.subtitleBold(
                AppWord.welcomeToOurApp,
                maxLines: 1,
                fontColor: AppColors.darkBlue,
              ),
            ),
            actions: const [
              BackArrow(),
            ],
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
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  ScreenDimensions.heightPercentage(context, 1),
                              horizontal:
                                  ScreenDimensions.widthPercentage(context, 2)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText.small(
                                AppWord.nationalNumber,
                                fontColor: AppColors.darkBlue,
                              ),
                              AppText.small(
                                '93939393939',
                                fontColor: AppColors.darkBlue,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  ScreenDimensions.heightPercentage(context, 1),
                              horizontal:
                                  ScreenDimensions.widthPercentage(context, 2)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText.small(
                                AppWord.militarySituation,
                                fontColor: AppColors.darkBlue,
                              ),
                              SizedBox(
                                  width: ScreenDimensions.widthPercentage(
                                      context, 21),
                                  child: AppText.small(
                                    'مؤجل',
                                    fontColor: AppColors.darkBlue,
                                    textAlign: TextAlign.center,
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: ScreenDimensions.widthPercentage(context, 30),
                    child: Image.asset(AppImages.hello,
                        filterQuality: FilterQuality.high, fit: BoxFit.cover),
                  ),
                ],
              ),
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
                      borderRadius: BorderRadius.circular(
                          ScreenDimensions.radius(context, 1)),
                      border: Border.all(color: AppColors.blueAccent),
                    ),
                    alignment: Alignment.center,
                    child: AppText.smallBold(
                      AppWord.notification,
                      fontColor: AppColors.darkBlue,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: ScreenDimensions.widthPercentage(context, 90),
                height: ScreenDimensions.heightPercentage(context, 65),
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:  EdgeInsets.symmetric(vertical: ScreenDimensions.heightPercentage(context, 1)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: ScreenDimensions.widthPercentage(context, 4),
                              height: ScreenDimensions.heightPercentage(context, 2),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.black),
                                color: AppColors.blueAccent,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(
                                width: ScreenDimensions.widthPercentage(context, 80),
                                child: AppText.smallBold(
                                  'تم قبول طلبك بنجاح',
                                  maxLines: 2,
                                  textAlign: TextAlign.right,
                                ))
                          ],
                        ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BackArrow extends StatelessWidget {
  const BackArrow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: SizedBox(
        width: ScreenDimensions.widthPercentage(context, 10),
        height: ScreenDimensions.heightPercentage(context, 5),
        child: Icon(Icons.arrow_forward,
            color: AppColors.darkBlue,
            size: ScreenDimensions.heightPercentage(context, 2.5)),
      ),
    );
  }
}
