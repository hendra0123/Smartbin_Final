import 'package:flutter/material.dart';

class PointsController {
  static final ValueNotifier<int> points = ValueNotifier<int>(1000);

  static void updatePoints(int newPoints) {
    points.value = newPoints;
  }

  static void addPoints(int amount) {
    points.value += amount;
  }

  static void subtractPoints(int amount) {
    points.value -= amount;
  }
}
