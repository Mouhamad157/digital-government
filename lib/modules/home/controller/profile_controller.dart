import 'package:digital_government/core/firebase/database.dart';
import 'package:digital_government/core/storage_handler/storage_handler.dart';
import 'package:digital_government/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';
import '../../../core/general_models/profile_model.dart';

class ProfileController extends GetxController{
bool isLoading = true;
late FirebaseDataSource firebaseDataSource ;
late HomeController homeController ;
SoliderModel? soliderModel;
void getProfile()async {
  isLoading = true;
  update();
  await firebaseDataSource.getSoliderByPrivateNumber(privateNumber: int.parse(StorageHandler().userId)).then((value) {
    if(value==null){
      isLoading  = true;
      Get.snackbar('عذرا', 'تأكد من اتصالك بالانترنت');
      update();
      return;
    }else{
      isLoading = false;
      soliderModel = value;
      update();
    }
  });
  update();
}

@override
  void onInit() {
  firebaseDataSource = Get.find();
  homeController = Get.find();
  getProfile();
  super.onInit();
  }
}