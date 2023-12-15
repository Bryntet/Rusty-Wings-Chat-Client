import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:chat_app_client/conversation.dart';
import 'package:http/http.dart' as http;
import 'message.dart';
import 'user.dart'; // Import other model files accordingly

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<User> createUser(NewUser user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create-user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user),
    );

    if (response.statusCode == 200) {
      // Assuming the response contains the user ID
      var data = json.decode(response.body);
      return User.fromJson(
          data); // Adjust based on your actual response structure
    } else {
      throw Exception('Failed to create user');
    }
  }

  Future<List<Conversation>> getConversationsFromUser(User user) async {
    final response =
        await http.get(Uri.parse('$baseUrl/conversations/${user.userId}'));

    if (response.statusCode == 200) {
      List<dynamic> convsJson = json.decode(response.body);
      return convsJson.map((json) => Conversation.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }

  Future<List<Message>> getMessages(Conversation conv) async {
    final response =
        await http.get(Uri.parse('$baseUrl/conversation/${conv.id}'));
    if (response.statusCode == 200) {
      List<dynamic> messagesJson = json.decode(response.body);
      return messagesJson.map((json) => Message.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }

  Future<User?> getUser(String username) async {
    if (await userExists(username)) {
      final response = await http.get(Uri.parse('$baseUrl/user/$username'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return User.fromJson(data);
      } else {
        throw Exception('Failed to load user');
      }
    } else {
      return null;
    }
  }

  Future<Message> createMessage(NewMessage message) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create-message'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(message.toJson()),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return Message.fromJson(data);
    } else {
      throw Exception('Failed to create message');
    }
  }

  Future<Conversation> createConversation(
      NewConversation newConversation) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create-conversation'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(newConversation.toJson()),
    );
    if (response.statusCode == 200) {
      return Conversation.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create conversation');
    }
  }

  Future<ConversationUser> getConversationUsers(String conversationId) async {
    final response = await http
        .get(Uri.parse('$baseUrl/conversation-users/$conversationId'));
    if (response.statusCode == 200) {
      return ConversationUser.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to get users from conversation.");
    }
  }

  Future<bool> userExists(String username) async {
    final response =
        await http.get(Uri.parse('$baseUrl/user-exists/$username'));
    if (response.statusCode == 200) {
      return bool.parse(response.body);
    } else {
      return false;
    }
  }
// Add similar methods for other endpoints...
}
