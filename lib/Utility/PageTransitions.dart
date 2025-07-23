// lib/Utils/PageTransitions.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageTransitions {
  static Future<T?> fadeIn<T>(Widget page) {
    final result = Get.to<T>(() => page, transition: Transition.fadeIn, duration: const Duration(milliseconds: 500));
    return result ?? Future.value(null);
  }

  static Future<T?> slideFromRight<T>(Widget page) {
    final result = Get.to<T>(() => page, transition: Transition.rightToLeftWithFade, duration: const Duration(milliseconds: 500));
    return result ?? Future.value(null);
  }

  static Future<T?> zoom<T>(Widget page) {
    final result = Get.to<T>(() => page, transition: Transition.zoom, duration: const Duration(milliseconds: 400));
    return result ?? Future.value(null);
  }
}
