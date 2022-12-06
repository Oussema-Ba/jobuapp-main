import 'package:flutter/cupertino.dart';

class StateProvider with ChangeNotifier {
  int currentIndex = 0;
  
  changeScreen(int i) {
    currentIndex = i;
    notifyListeners();
  }
}
