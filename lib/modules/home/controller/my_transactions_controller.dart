import 'package:digital_government/core/firebase/database.dart';
import 'package:digital_government/core/general_models/transactions_model.dart';
import 'package:digital_government/core/storage_handler/storage_handler.dart';
import 'package:digital_government/modules/home/controller/profile_controller.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class MyTransactionsController extends GetxController {
  bool isLoading = true;
  late FirebaseDataSource firebaseDataSource;
  late ProfileController profileController;
  late HomeController homeController;
  List<TransactionsModel>? transactions = [];

  void getTransactions() async {
    isLoading = true;
    update();
    await firebaseDataSource
        .getTransactionsByPrivateNumber(
            privateNumber: int.parse(StorageHandler().userId))
        .then((value) {
      if (value!.isNotEmpty) {
        for (var element in value) {
          transactions!.add(element);
        }
        isLoading = false;
        update();
      } else {
        isLoading = false;
        Get.snackbar('عذرا', 'لا يوجد معاملات ');
        update();
      }
    });
  }

  @override
  void onInit() {
    firebaseDataSource = Get.find();
    profileController = Get.find();
    homeController = Get.find();
    getTransactions();
    super.onInit();
  }
}
