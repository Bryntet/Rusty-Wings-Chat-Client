import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import 'package:chat_app_client/main.dart';
import 'package:chat_app_client/theme.dart';
import 'package:flutter/material.dart';
import 'create_user_screen.dart'; // Import your CreateUserScreen
import 'login_screen.dart';
import 'messages_screen.dart'; // Import your MessagesScreen

class HomeScreen extends StatelessWidget {
  final colorMap = getColorMap();

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
              child: const Text('Create User'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateUserScreen()),
                );

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorMap['green'],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginUserScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorMap['lavender'],
              ),
            ),
            // Add more buttons for other functionalities
          ],
        ),
      ),

    );
  }
}
