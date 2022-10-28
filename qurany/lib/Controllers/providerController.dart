import 'package:flutter/material.dart';
import 'package:qurany/main.dart';

class ProviderController extends ChangeNotifier {
  bool? initTheme() {
    if (sharedPreferences!.getBool("theme") == null) {
      return true;
    } else {
      return sharedPreferences!.getBool("theme");
    }
  }

  void changeTheme() {
    bool theme = false;
    if (sharedPreferences!.getBool("theme") == null) {
      theme = true;
    } else {
      theme = sharedPreferences!.getBool("theme")!;
    }
    sharedPreferences!.setBool("theme", !theme);
    notifyListeners();
  }

  int _verse = 1;

  int get verseNumber => _verse;

  void verseChose(int index) {
    _verse = index;
    notifyListeners();
  }
}
