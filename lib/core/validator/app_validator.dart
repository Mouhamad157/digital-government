import 'package:digital_government/core/texts/words.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppValidator{
  static AppValidator? _instance;

  AppValidator._();

  factory AppValidator() => _instance ??= AppValidator._();

  String? nationalNumberValidator(String? value){
    if(value!.isEmpty){
      return AppWord.emptyNationalNumber;
    }
    if(value.length!=11){
      return AppWord.nationalNumberMustBe11;
    }
    return null;
  }
  String? passwordValidator(String? value){
    if(value!.isEmpty){
      return AppWord.emptyPassword;
    }
    if(value.length<8){
      return AppWord.shortPassword;
    }
    return null;
  }
  String? phoneNumberValidator(String? value){
    if(value!.isEmpty){
      return AppWord.emptyPhoneNumber;
    }
    if(!value.isPhoneNumber){
      return AppWord.notPhoneNumber;
    }
    return null;
  }
  String? accountNumberValidator(String? value){
    if(value!.isEmpty){
      return AppWord.emptyAccountNumber;
    }
    return null;
  }
  String? fullNameValidator(String? value){
    if(value!.isEmpty){
      return AppWord.emptyFullName;
    }
    if(value.length<9){
      return AppWord.tooShortFullName;
    }
    return null;
  }
}