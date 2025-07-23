import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Routes/AppRoutes.dart';
import 'Services/LocalStorageService.dart';
import 'Views/HomeScreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Video Details',
      initialRoute: AppRoutes.browser,
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.getPages,
    );
  }
}
