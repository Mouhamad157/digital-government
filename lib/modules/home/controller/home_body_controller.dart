import 'package:digital_government/core/components/components.dart';
import 'package:digital_government/core/constants/colors/colors.dart';
import 'package:digital_government/core/constants/images/images.dart';
import 'package:digital_government/core/texts/words.dart';
import 'package:digital_government/modules/home/view/postponement.dart';
import 'package:digital_government/modules/notifications/view/notification_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBodyController extends GetxController {
  List<Color> itemColor = [
    AppColors.white,
    AppColors.blueAccent,
    AppColors.blue,
    AppColors.darkBlue,
    AppColors.grey
  ];
  List<Color> itemTextColor = [
    AppColors.darkBlue,
    AppColors.darkBlue,
    AppColors.white,
    AppColors.white,
    AppColors.darkBlue
  ];
  List<String> itemImage = [
    AppImages.document,
    AppImages.cashPayment,
    AppImages.block,
    AppImages.examination,
    AppImages.book
  ];
  List<String> itemTitle = [
    AppWord.postponement,
    AppWord.paymentFee,
    AppWord.exemption,
    AppWord.objectionToTheMedicalExamination,
    AppWord.createAnArmyNoteBook,
  ];

  List<void Function()> onItemTap =
      [
        ()  {
      Get.to(const PostponementScreen(),transition: Transition.zoom,duration: const Duration(milliseconds: 700));
    },
        ()  {Get.dialog( AppDialog(content: AppWord.theAllowanceServiceWillBeAvailableSoon,));},
        ()  {Get.dialog( AppDialog(content: AppWord.theExemptionServiceWillBeAvailableSoon,));},
        ()  {Get.dialog( AppDialog(content: AppWord.theObjectionOfMedicalExaminationWillBeAvailableSoon,));},
        ()  {Get.dialog( AppDialog(content: AppWord.theCreationOfArmyNoteBookServiceWillBeAvailableSoon,));},
  ];
}
