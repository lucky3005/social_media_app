import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/views/home_screen.dart';

void main(List<String> args) {
  runApp(const ApiApp());
}

class ApiApp extends StatelessWidget {
  const ApiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
