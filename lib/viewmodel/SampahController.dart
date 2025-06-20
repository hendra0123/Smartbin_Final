import 'package:flutter/material.dart';

class SampahController {
  static final ValueNotifier<int> totalSampah = ValueNotifier<int>(0);

  static void addSampah(int count) {
    totalSampah.value += count;
  }

  static void resetSampah() {
    totalSampah.value = 0;
  }
}
