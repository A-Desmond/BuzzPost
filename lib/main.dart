import 'package:buzpost/Controllers/auth_controller.dart';
import 'package:buzpost/Views/Screens/Auth/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BuzPost',
      theme: ThemeData.dark().copyWith(
        
        useMaterial3: true,
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: Register(),
    );
  }
}
