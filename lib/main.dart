import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/screens/animated_list/animated_list.dart';
import 'package:flutter_ui_kits/screens/animated_list/fake_data.dart';
import 'package:flutter_ui_kits/screens/fluid_app_bar/fluid_app_bar_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedListWidget(),
    );
  }
}
