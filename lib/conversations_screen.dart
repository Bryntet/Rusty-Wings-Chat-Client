import 'package:chat_app_client/conversation.dart';

import 'messages_screen.dart';
import 'user.dart';
import 'package:flutter/material.dart';
import 'api_service.dart';

class ConversationScreen extends StatefulWidget {
  final User user;

  const ConversationScreen({Key? key, required this.user}) : super(key: key);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final ApiService _apiService = ApiService('http://localhost:3000');
  final List<Conversation> _conversations = [];

  @override
  void initState() {
    super.initState();
    _loadConversations();
  }

  void _showAddConversationDialog(BuildContext context) {
    TextEditingController receiverIdController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('New Conversation'),
          content: TextField(
            controller: receiverIdController,
            decoration: const InputDecoration(hintText: "Receiver ID"),
            keyboardType: TextInputType.number, // Since ID is a number
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Create'),
              onPressed: () {
                int receiverId = int.tryParse(receiverIdController.text) ?? 0;
                _createNewConversation(receiverId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _createNewConversation(int receiverId) async {
    NewConversation newConversation =
        NewConversation(sender: widget.user.userId, receiver: receiverId);

    try {
      Conversation conversation =
          await _apiService.createConversation(newConversation);
      setState(() {
        _conversations.add(conversation);
      });
    } catch (e) {
      // Handle any errors here
    }
  }

  void _loadConversations() async {
    List<Conversation> conversations =
        await _apiService.getConversationsFromUser(widget.user);

    _conversations.addAll(conversations);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversations'),
      ),
      body: ListView.builder(
        itemCount: _conversations.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessagesScreen(
                      conversation: _conversations[index], user: widget.user),
                ),
              );
            },
            child: ListTile(
              subtitle: Text(_conversations[index].id.toString()),
              title: Text('Conversation ${_conversations[index].id}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddConversationDialog(context),
        tooltip: 'Create New Conversation',
        child: const Icon(Icons.add),
      ),
    );
  }
}
