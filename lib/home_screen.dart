import 'package:chat_app_client/theme.dart';
import 'package:flutter/material.dart';
import 'create_user_screen.dart'; // Import your CreateUserScreen
import 'login_screen.dart';
// Import your MessagesScreen

class HomeScreen extends StatelessWidget {
  final colorMap = getColorMap();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: colorMap['mantle'],
        foregroundColor: colorMap["lavender"],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateUserScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorMap['green'],
              ),
              child: const Text('Create User'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginUserScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorMap['lavender'],
              ),
              child: const Text('Login'),
            ),
            // Add more buttons for other functionalities
          ],
        ),
      ),
    );
  }
}
