import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import 'package:chat_app_client/theme.dart';
import 'package:flutter/material.dart';
import 'user.dart';
import 'api_service.dart';
import 'home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: catppuccinTheme(catppuccin.macchiato),
      home: HomeScreen(),

    );
  }
}