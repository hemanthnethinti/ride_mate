import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:ride_mate/splash_screen.dart';


void main() {
     runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}