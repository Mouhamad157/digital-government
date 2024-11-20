import 'dart:ui';

import 'package:delayed_display/delayed_display.dart';
import 'package:digital_government/core/components/components.dart';
import 'package:digital_government/core/constants/colors/colors.dart';
import 'package:digital_government/core/constants/images/images.dart';
import 'package:digital_government/core/texts/words.dart';
import 'package:digital_government/core/utils/app_fonts.dart';
import 'package:digital_government/core/utils/dimensions.dart';
import 'package:digital_government/modules/home/controller/home_body_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeBody extends GetView<HomeBodyController> {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                AppWord.ourService,
                fontColor: AppColors.darkBlue,
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.topCenter,
          width: ScreenDimensions.widthPercentage(context, 90),
          height: ScreenDimensions.heightPercentage(context, 60),
          child: ListView.builder(
            itemCount: controller.itemTextColor.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenDimensions.heightPercentage(context, 1)),
                child: GestureDetector(
                  onTap: controller.onItemTap[index],
                  child: DelayedDisplay(
                      delay: Duration(milliseconds: 10 + (index * 50)),
                      slidingBeginOffset: Offset(1,0),
                      child: Container(
                        width: ScreenDimensions.widthPercentage(context, 80),
                        height: ScreenDimensions.heightPercentage(context, 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: controller.itemColor[index],
                            borderRadius: BorderRadius.circular(
                                ScreenDimensions.radius(context, 1)),
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 5),
                                  color: AppColors.grey,
                                  blurRadius: 5,
                                  spreadRadius: 2)
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                                width: ScreenDimensions.widthPercentage(
                                    context, 70),
                                child: AppText(
                                  controller.itemTitle[index],
                                  style: TextStyle(
                                      color: controller.itemTextColor[index],
                                      fontSize:
                                          AppFonts.subTitleFont(context) - 5),
                                  textAlign: TextAlign.center,
                                )),
                            SizedBox(
                              width:
                                  ScreenDimensions.widthPercentage(context, 20),
                              child:
                                  SvgPicture.asset(controller.itemImage[index]),
                            ),
                          ],
                        ),
                      )),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

