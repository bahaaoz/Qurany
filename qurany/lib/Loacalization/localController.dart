import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurany/main.dart';

class LocalController extends GetxController {
  Locale? get initLocal {
    if (sharedPreferences!.getString("lang") == null) {
      return Get.deviceLocale;
    } else {
      String? locale = sharedPreferences!.getString("lang");
      return Locale(locale!);
    }
  }

  void changeLanguge(String lang) {
    sharedPreferences!.setString("lang", lang);
    Get.updateLocale(Locale(lang));
  }
}
