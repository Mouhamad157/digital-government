import 'package:digital_government/core/constants/images/images.dart';
import 'package:digital_government/core/storage_handler/storage_handler.dart';
import 'package:digital_government/modules/home/controller/my_transactions_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/components/components.dart';
import '../../../core/constants/colors/colors.dart';
import '../../../core/texts/words.dart';
import '../../../core/utils/dimensions.dart';

class MyTransactionsScreen extends GetView<MyTransactionsController> {
  const MyTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyTransactionsController());
    return GetBuilder<MyTransactionsController>(builder: (_) {
      return controller.isLoading
          ? SizedBox(
              height: ScreenDimensions.heightPercentage(context, 70),
              child: Center(
                child: CircularProgressIndicator(color: AppColors.darkBlue),
              ))
          : Column(
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
                        borderRadius: BorderRadius.circular(
                            ScreenDimensions.radius(context, 1)),
                        border: Border.all(color: AppColors.blueAccent),
                      ),
                      alignment: Alignment.center,
                      child: AppText.smallBold(
                        AppWord.myTransactions,
                        fontColor: AppColors.darkBlue,
                      ),
                    ),
                  ),
                ),
                if(controller.transactions!.isNotEmpty)
                SizedBox(
                  width: ScreenDimensions.widthPercentage(context, 90),
                  height: ScreenDimensions.heightPercentage(context, 65),
                  child: ListView.builder(
                    itemCount: controller.transactions!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (controller.transactions![index].status ==
                              'pending') {
                            Get.dialog(GeneralDialog(children: [
                              SizedBox(
                                width: ScreenDimensions.widthPercentage(
                                    context, 90),
                                height: ScreenDimensions.heightPercentage(
                                    context, 35),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                            width: ScreenDimensions
                                                .widthPercentage(context, 40),
                                            child: AppText.small(
                                              'allowed',
                                              fontColor: Colors.green,
                                              textAlign: TextAlign.center,
                                            )),
                                        SizedBox(
                                            width: ScreenDimensions
                                                .widthPercentage(context, 40),
                                            child: AppText.subtitle(
                                              AppWord.requestDetails,
                                              fontColor: AppColors.darkBlue,
                                              textAlign: TextAlign.right,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                            width: ScreenDimensions
                                                .widthPercentage(context, 40),
                                            child: AppText.smallBold(
                                              StorageHandler().userId,
                                              fontColor: AppColors.darkBlue,
                                              textAlign: TextAlign.center,
                                            )),
                                        SizedBox(
                                            width: ScreenDimensions
                                                .widthPercentage(context, 40),
                                            child: AppText.smallBold(
                                              AppWord.nationalNumber,
                                              fontColor: AppColors.darkBlue,
                                              textAlign: TextAlign.right,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                            width: ScreenDimensions
                                                .widthPercentage(context, 40),
                                            child: AppText.smallBold(
                                              controller
                                                  .homeController
                                                  .civilianDetails!
                                                  .militaryStatus,
                                              fontColor: AppColors.darkBlue,
                                              textAlign: TextAlign.center,
                                            )),
                                        SizedBox(
                                            width: ScreenDimensions
                                                .widthPercentage(context, 40),
                                            child: AppText.smallBold(
                                              AppWord.militarySituation,
                                              fontColor: AppColors.darkBlue,
                                              textAlign: TextAlign.right,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          width:
                                              ScreenDimensions.widthPercentage(
                                                  context, 40),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AppText.smallBold(
                                                '100000000000',
                                                fontColor: AppColors.darkBlue,
                                              ),
                                              AppText.small('sp'),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            width: ScreenDimensions
                                                .widthPercentage(context, 40),
                                            child: AppText.smallBold(
                                              AppWord.totalFeesToBePaid,
                                              fontColor: AppColors.darkBlue,
                                              textAlign: TextAlign.right,
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      width: ScreenDimensions.widthPercentage(
                                          context, 80),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          AppText.smallBold(
                                            'سيتم اقتطاع مبلغ المعاملة من الحساب المصرفي ذو الرقم ',
                                            maxLines: 2,
                                            fontColor: AppColors.darkBlue,
                                          ),
                                          AppText.small(
                                            controller.profileController
                                                .soliderModel!.accountNumber
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ScreenDimensions.widthPercentage(
                                                  context, 20)),
                                      child: AppButton(
                                        buttonName: AppWord.continueForPayment,
                                        onTap: () {
                                          controller.firebaseDataSource.pay(
                                              controller.transactions![index]
                                                  .docName).then((value) {
                                                    Get.back();
                                                    controller.getTransactions();
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]));
                          }
                        },
                        child: Container(
                          width: ScreenDimensions.widthPercentage(context, 80),
                          height:
                              ScreenDimensions.heightPercentage(context, 12),
                          margin: EdgeInsets.symmetric(
                              vertical: ScreenDimensions.heightPercentage(
                                  context, 1.5),
                              horizontal:
                                  ScreenDimensions.widthPercentage(context, 1)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                ScreenDimensions.radius(context, 1)),
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 5),
                                  blurRadius: 5,
                                  blurStyle: BlurStyle.outer,
                                  color: AppColors.grey),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: ScreenDimensions.widthPercentage(
                                    context, 70),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          width:
                                              ScreenDimensions.widthPercentage(
                                                  context, 20),
                                          child: AppText.smallBold(
                                            AppWord.nationalNumber,
                                            fontColor: AppColors.darkBlue,
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              ScreenDimensions.widthPercentage(
                                                  context, 30),
                                          child: AppText.smallBold(
                                            StorageHandler().userId,
                                            fontColor: AppColors.darkBlue,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          width:
                                              ScreenDimensions.widthPercentage(
                                                  context, 20),
                                          child: AppText.smallBold(
                                            AppWord.requestId,
                                            fontColor: AppColors.darkBlue,
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              ScreenDimensions.widthPercentage(
                                                  context, 30),
                                          child: AppText.smallBold(
                                            controller.transactions![index].id
                                                .toString(),
                                            fontColor: AppColors.darkBlue,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          width:
                                              ScreenDimensions.widthPercentage(
                                                  context, 20),
                                          child: AppText.smallBold(
                                            AppWord.requestStatus,
                                            fontColor: AppColors.darkBlue,
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              ScreenDimensions.widthPercentage(
                                                  context, 30),
                                          child: AppText.smallBold(
                                            controller
                                                .transactions![index].status,
                                            fontColor: AppColors.darkBlue,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  width: ScreenDimensions.widthPercentage(
                                      context, 10),
                                  child: SvgPicture.asset(AppImages.document)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if(controller.transactions!.isEmpty)
                  AppText.subtitleBold('لا يوجد معاملات')
              ],
            );
    });
  }
}
