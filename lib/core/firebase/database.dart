import 'dart:io';
import 'dart:math' as MATH;
import 'package:digital_government/core/general_models/education_orders_model.dart';
import 'package:digital_government/core/general_models/profile_model.dart';
import 'package:digital_government/core/general_models/transactions_model.dart';
import 'package:digital_government/core/storage_handler/storage_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import '../general_models/civilian_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDataSource extends GetxController {
  late CollectionReference citizenServicesCollection;
  late CollectionReference ministryOfDefenseCollection;
  late CollectionReference highEducationCollection;
  List<Civilian> civilians = [];
  List<EducationOrderModel> educationOrders = [];
  List<TransactionsModel> transactions = [];
  List<SoliderModel> solider = [];

  Future _initDatabase() async {
    citizenServicesCollection =
        FirebaseFirestore.instance.collection('Citizen services');
    Get.log('citizenServicesCollection : $citizenServicesCollection');
    ministryOfDefenseCollection =
        FirebaseFirestore.instance.collection('Ministry of Defense');
    Get.log('ministryOfDefenseCollection : $ministryOfDefenseCollection');
    highEducationCollection =
        FirebaseFirestore.instance.collection('High Education Military');
    Get.log('ministryOfDefenseCollection : $highEducationCollection');
    getEducationOrders();
  }

  Future<List<Civilian>> getCivilians() async {
    if (civilians.isEmpty) {
      await citizenServicesCollection
          .doc('users')
          .collection('data')
          .get()
          .then((value) {
        for (var element in value.docs) {
          Get.log('${element.id} : ${element['name']}');
          civilians.add(Civilian.fromDoc(element));
          Get.log('${civilians.last.name} document add successfully');
        }
      });
    }
    return civilians;
  }

  Future<List<EducationOrderModel>> getEducationOrders() async {
    if (educationOrders.isEmpty) {
      await highEducationCollection
          .doc('orders')
          .collection('data')
          .get()
          .then((value) {
        for (var element in value.docs) {
          Get.log('${element.id} : ${element['full_name']}');
          educationOrders.add(EducationOrderModel.fromDoc(document: element));
          Get.log('${educationOrders.last.fullName} document add successfully');
        }
      });
    }
    return educationOrders;
  }

  Future<bool> _checkPrivateNumber(int privateNumber) async {
    bool result = false;
    await getCivilians().then((value) {
      Iterable<Civilian> tmp =
          value.where((element) => element.privateNumber == privateNumber);
      if (tmp.isNotEmpty) {
        result = true;
      }
    });
    return result;
  }

  Future<Civilian?> getCivilianByPrivateNumber(
      {required int privateNumber}) async {
    if (await _checkPrivateNumber(privateNumber)) {
      return civilians
          .where((element) => element.privateNumber == privateNumber)
          .first;
    }
    return null;
  }

  Future<bool> login(
      {required int privateNumber, required String password}) async {
    bool result = false;
    await ministryOfDefenseCollection
        .doc('users')
        .collection('data')
        .get()
        .then((value) {
      print(password);
      value.docs.forEach((element) {
        if (element['password'] == password &&
            element['private_number'] == privateNumber) {
          result = true;
        }
      });
    });
    return result;
  }

  String link = '';

  Future<String> uploadImage(File image) async {
    await FirebaseStorage.instance
        .ref()
        .child('${getRandomString(15)}.png')
        .putFile(image)
        .then((value) {
      value.ref.getDownloadURL().then((tmp) {
        link = tmp;
        print(tmp);
      });
    });
    print('link is : $link');
    return link;
  }

  Future<String> signup({
    required int privateNumber,
    required String phoneNumber,
    required String password,
    required String accountNumber,
    required File image,
    required int militaryNumber,
  }) async {
    String result = 'done';
    if (await _checkPrivateNumber(privateNumber)) {
      await getSolider();
      if (solider
          .any((element) => element.phoneNumber == int.parse(phoneNumber))) {
        result = 'الرقم مسجل بالفعل';
      } else {
        await FirebaseStorage.instance
            .ref()
            .child('${getRandomString(15)}.png')
            .putFile(image)
            .then((value) {
          value.ref.getDownloadURL().then((tmp) async {
            await ministryOfDefenseCollection
                .doc('users')
                .collection('data')
                .add({
              'private_number': privateNumber,
              'phone_number': int.parse(phoneNumber),
              'password': password,
              'account_number': int.parse(accountNumber),
              'image': tmp,
              'id': solider.last.id + 1,
              'military_number': militaryNumber,
            }).then((value) async {
              Get.log(value.id);
              await StorageHandler().setUserId(privateNumber.toString());
            }, onError: (e) {
              Get.log(e.toString());
            });
          });
        });
      }
    } else {
      result = 'الرقم الوطني غير صحيح';
    }
    return result;
  }

  Future<List<SoliderModel>> getSolider() async {
    if (true) {
      solider.clear();
      await ministryOfDefenseCollection
          .doc('users')
          .collection('data')
          .get()
          .then((value) {
        for (var element in value.docs) {
          solider.add(SoliderModel.fromDoc(document: element));
        }
      });
    }
    return solider;
  }

  Future<SoliderModel?> getSoliderByPrivateNumber(
      {required int privateNumber}) async {
    await getSolider();
    Iterable<SoliderModel> x =
        solider.where((element) => element.privateNumber == privateNumber);
    return x.first;
  }

  Future<List<TransactionsModel>> getTransactions() async {
    if (true) {
      transactions.clear();
      await ministryOfDefenseCollection
          .doc('transactions')
          .collection('data')
          .get()
          .then((value) {
        for (var element in value.docs) {
          print(element['status']);
          transactions.add(TransactionsModel.fromDoc(document: element));
        }
      });
    }
    return transactions;
  }

  Future<bool> addTransactions(
      {required int id,
      required int privateNumber,
      required String status}) async {
    bool isDone = false;
    await ministryOfDefenseCollection
        .doc('transactions')
        .collection('data')
        .add({
      'id': id,
      'private_number': privateNumber,
      'status': status,
    }).then((value) {
      isDone = true;
      Get.log(value.id);
    }, onError: (e) {
      Get.log(e.toString());
    });
    return isDone;
  }

  Future<bool> addTransactionsEducation(
      {required int id,
      required int privateNumber,
      required String status,
      required String fullName,
      required Timestamp createdAt}) async {
    bool isDone = false;
    await highEducationCollection.doc('orders').collection('data').add({
      'id': id,
      'private_number': privateNumber,
      'status': status,
      'full_name': fullName,
      'created_at': createdAt,
    }).then((value) {
      isDone = true;
      Get.log(value.id);
    }, onError: (e) {
      Get.log(e.toString());
    });
    return isDone;
  }

  Future<List<TransactionsModel>?> getTransactionsByPrivateNumber(
      {required int privateNumber}) async {
    await getTransactions();
    List<TransactionsModel> tmp = [];
    Iterable<TransactionsModel> x =
        transactions.where((element) => element.privateNumber == privateNumber);
    print('length is : ${x.length}');
    for (var value in x) {
      print(value.status);
      tmp.add(value);
    }
    return tmp;
  }

  Future<bool> pay(String docName) async {
    bool result = false;
    await ministryOfDefenseCollection
        .doc('transactions')
        .collection('data')
        .doc(docName)
        .update({'status': 'done'}).then((value) async {
      getCivilianByPrivateNumber(
              privateNumber: int.parse(StorageHandler().userId))
          .then((value) async {
        await citizenServicesCollection
            .doc('users')
            .collection('data')
            .doc(value!.docName)
            .update({'military_status': 'delayed'});
      });
    });
    return result;
  }

  @override
  void onInit() {
    _initDatabase();
    super.onInit();
  }
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
MATH.Random _rnd = MATH.Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
