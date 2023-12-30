import 'package:flutter/material.dart';

class MainScreenPrvider extends ChangeNotifier {
  int selectedScreen = 0;

  changeScreen(int index) {
    selectedScreen = index;
    notifyListeners();
  }
}
