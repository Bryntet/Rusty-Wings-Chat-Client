import 'dart:developer';

import 'package:chat_app_client/conversations_screen.dart';
import 'package:chat_app_client/theme.dart';
import 'package:flutter/material.dart';
import 'user.dart';
import 'api_service.dart';

class LoginUserScreen extends StatefulWidget {
  const LoginUserScreen({super.key});

  @override
  _LoginUserScreenState createState() => _LoginUserScreenState();
}

class _LoginUserScreenState extends State<LoginUserScreen> {
  final colorMap = getColorMap();

  final TextEditingController _usernameController = TextEditingController();
  final ApiService _apiService = ApiService('http://localhost:3000');

  void _getUser() async {
    String id = _usernameController.text;
    try {
      User? user = await _apiService.getUser(id);
      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConversationScreen(user: user),
          ),
        );
      }
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login with username'),
        foregroundColor: colorMap["lavender"],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration:
                  const InputDecoration(labelText: 'Username', filled: true),
            ),
            ElevatedButton(
              onPressed: _getUser,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    colorMap['lavender'], // Use lavender color from colorMap
              ),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
