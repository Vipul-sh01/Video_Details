// lib/routes/app_routes.dart
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:videoplayer/Models/MovieDetailModel.dart';

import '../ViewModels/MovieController.dart';
import '../Views/DetailScreen.dart';
import '../Views/HomeScreen.dart';

abstract class AppRoutes {
  final controller = Get.put(MovieController());
  static const browser = '/browser';
  static const detail = '/detail';

  static final List<GetPage> getPages = [
    GetPage(name: browser, page: () => BrowseScreen()),
    GetPage(name: detail, page: () => DetailedScreen(detail as MovieDetailModel)),
  ];
}
