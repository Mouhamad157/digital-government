import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_government/core/constants/colors/colors.dart';
import 'package:digital_government/core/firebase/database.dart';
import 'package:digital_government/core/general_models/civilian_model.dart';
import 'package:digital_government/core/storage_handler/storage_handler.dart';
import 'package:digital_government/core/texts/words.dart';
import 'package:digital_government/modules/home/controller/home_controller.dart';
import 'package:digital_government/modules/home/controller/my_transactions_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/components/components.dart';
import '../../../core/constants/images/images.dart';
import '../../../core/utils/dimensions.dart';

class PostponementController extends GetxController {
  late HomeController homeController;

  late FirebaseDataSource firebaseDataSource;

  List<String> itemContent = [
    AppWord.studyPostponement,
    AppWord.travelPostponement,
    AppWord.breadWinnerPostponement,
    AppWord.singlePostponement,
    AppWord.administrativePostponement,
    AppWord.expatriatesPostponement,
  ];
  List<Color> itemColor = [
    AppColors.blueAccent,
    AppColors.blue,
    AppColors.darkBlue,
    AppColors.grey,
    AppColors.white,
    AppColors.grey,
  ];

  void sendRequest() async {
    await firebaseDataSource
        .addTransactions(
      id: firebaseDataSource.transactions.length + 1,
      privateNumber: int.parse(StorageHandler().userId),
      status: 'waiting',
    )
        .then((value) async {
      if (value) {
        Civilian? tmp = await firebaseDataSource.getCivilianByPrivateNumber(
            privateNumber: int.parse(StorageHandler().userId));
        firebaseDataSource.addTransactionsEducation(
          id: firebaseDataSource.educationOrders.length + 1,
          privateNumber: int.parse(StorageHandler().userId),
          status: 'waiting',
          fullName: '${tmp!.name} ${tmp.familyName}',
          createdAt: Timestamp.now(),
        ).then((value) {
          if(value){
            Get.dialog(
                WillPopScope(
                  onWillPop: () {
                    return Future.value(false);
                  },
                  child: GeneralDialog(
                    children: [
                      AppText.subtitleBold(AppWord.studyPostponement),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                            ScreenDimensions.heightPercentage(Get.context!, 1)),
                        child: SvgPicture.asset(
                          AppImages.timeManagement,
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
                            AppWord.theRequestWillBeSent,
                            maxLines: 3,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                barrierDismissible: false);
            Future.delayed(const Duration(milliseconds: 3000), () => Get.back());
            Get.snackbar('', 'تم إرسال الطلب سيتم إشعارك عندما يتم اتمام العملية');
          }else{}
        });
      } else {}
    });
  }

  @override
  void onInit() {
    homeController = Get.find();
    firebaseDataSource = Get.find()..getTransactions();
    super.onInit();
  }
}
