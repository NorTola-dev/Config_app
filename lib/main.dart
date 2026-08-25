import 'package:configapp/controller/notification_controller.dart';
import 'package:configapp/view/image_screen.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationController.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}