import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/screens/auto_hide_bottom_navigation/auto_hide_bottom_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AutoHideBottomNavigation(),
    );
  }
}