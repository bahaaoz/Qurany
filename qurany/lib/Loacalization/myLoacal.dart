import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyLocal extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys {
    return {
      "en": {
        "Home": "Home",
        "Change Theme": "Change Theme",
        "Welcome to Qurany": "Welcome to Qurany",
        "Last read": "Last read"
      },
      "ar": {
        "Home": "الصفحة الرئيسية",
        "Change Theme": "تغيير السمة",
        "Welcome to Qurany": "مرحبا بك ",
        "Last read": "أخر قراءة"
      },
    };
  }
}
