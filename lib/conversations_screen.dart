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
    TextEditingController titleController = TextEditingController();
    bool _isButtonPressed =
        false; // Flag to track if the 'Create' button was pressed

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          // Use StatefulBuilder to update the state of the dialog
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('New Conversation'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "Title",
                      errorText:
                          _isButtonPressed && titleController.text.isEmpty
                              ? 'Title cannot be empty'
                              : null,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Adds a small space between the text fields
                  TextField(
                    controller: receiverIdController,
                    decoration: InputDecoration(
                      hintText: "Receiver ID",
                      errorText:
                          _isButtonPressed && receiverIdController.text.isEmpty
                              ? 'Receiver ID cannot be empty'
                              : null,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
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
                    if (titleController.text.isEmpty ||
                        receiverIdController.text.isEmpty) {
                      setState(() {
                        // Call setState to update the dialog's state
                        _isButtonPressed =
                            true; // Update the flag when the button is pressed
                      });
                    } else {
                      int receiverId =
                          int.tryParse(receiverIdController.text) ?? 0;
                      String title = titleController.text;
                      _createNewConversation(receiverId, title);
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _createNewConversation(int receiverId, String title) async {
    NewConversation newConversation = NewConversation(
        sender: widget.user.userId, receiver: receiverId, title: title);

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
              subtitle: Text('Conversation id: ${_conversations[index].id}'),
              title: Text('Convo title: ${_conversations[index].title}'),
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
