import 'package:chat_app_client/conversations_screen.dart';
import 'package:chat_app_client/theme.dart';
import 'package:flutter/material.dart';
import 'messages_screen.dart';
import 'user.dart';
import 'api_service.dart';

class CreateUserScreen extends StatefulWidget {

  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final colorMap = getColorMap();
  final TextEditingController _usernameController = TextEditingController();
  final ApiService _apiService = ApiService('http://localhost:3000');

  void _createUser() async {
    NewUser newUser = NewUser(username: _usernameController.text);
    try {
      User user = await _apiService.createUser(newUser);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConversationScreen(user: user),
        ),
      );
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create User'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),

            ),
            ElevatedButton(
              onPressed: _createUser,
              child: Text('Create User'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorMap['green'], // Use lavender color from colorMap
              ),
            ),
          ],
        ),
      ),
    );
  }
}