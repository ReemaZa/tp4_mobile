import 'package:flutter/material.dart';

class BasketNotifier {
  static final ValueNotifier<int> basketVersion =
  ValueNotifier<int>(0);

  static void notifyChange() {
    basketVersion.value++;
  }
}
