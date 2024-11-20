import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class StorageHandler {
  StorageHandler._();

  static StorageHandler? _instance;

  factory StorageHandler() => _instance ??= StorageHandler._();

  final _storage = GetStorage('gold-shop');

  static Future<void> init() async {
    await GetStorage.init('gold-shop');
  }
  // Locale
  Future<void> setLocale(String locale) => _storage.write('locale', locale);

  Locale get locale {
    if (_storage.hasData('locale')) {
      var lang = _storage.read('locale');
      switch (lang) {
        case 'ar':
          return const Locale('ar');
        default:
          return const Locale('en');
      }
    }
    return const Locale('en');
  }

  String get lang {
    if (_storage.hasData('locale')) {
      var lang = _storage.read('locale');
      return lang;
    }
    return 'en';
  }

  bool get isAr => lang == 'ar';

  // User id
  Future<void> setUserId(String id) async => await _storage.write('userId', id);

  Future<void> removeUserId() => _storage.remove('userId');

  String get userId => _storage.read('userId') ?? 'no user id';

  bool get hasUserId => _storage.hasData('userId');

}
