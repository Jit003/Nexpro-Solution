import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexpro_solution/Services/notification_services.dart';
import 'Screens/Splash Screen/splash_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
