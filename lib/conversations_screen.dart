import 'package:chat_app_client/conversation.dart';
import 'package:chat_app_client/theme.dart';

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
  bool userDoesNotExist = false;

  @override
  void initState() {
    super.initState();
    _loadConversations();
  }

  void _showAddConversationDialog(BuildContext context) {
    TextEditingController recieverUsernameController = TextEditingController();
    TextEditingController titleController = TextEditingController();
    bool isButtonPressed =
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
                      errorText: isButtonPressed && titleController.text.isEmpty
                          ? 'Title cannot be empty'
                          : null,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Adds a small space between the text fields
                  TextFormField(
                    controller: recieverUsernameController,
                    decoration: InputDecoration(
                        hintText: "Receiver Username",
                        errorText: isButtonPressed &&
                                recieverUsernameController.text.isEmpty
                            ? 'Receiver Username cannot be empty'
                            : (isButtonPressed && userDoesNotExist
                                ? 'User does not exist.'
                                : null)),
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
                        recieverUsernameController.text.isEmpty) {
                      setState(() {
                        // Call setState to update the dialog's state
                        isButtonPressed =
                            true; // Update the flag when the button is pressed
                      });
                    } else {
                      _apiService
                          .getUser(recieverUsernameController.text)
                          .then((value) => {
                                if (value != null)
                                  {
                                    _createNewConversation(
                                        value.username, titleController.text)
                                  }
                              });

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

  void _createNewConversation(String receiver, String title) async {
    if (await _apiService.userExists(receiver)) {
      var res = await _apiService.getUser(receiver);
      if (res != null) {
        int userId = res.userId;

        NewConversation newConversation = NewConversation(
            sender: widget.user.userId, receiver: userId, title: title);
        Conversation conversation =
            await _apiService.createConversation(newConversation);
        setState(() {
          _conversations.add(conversation);
        });
      }
    } else {
      userDoesNotExist = true;
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
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _conversations.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MessagesScreen(
                            conversation: _conversations[index],
                            user: widget.user),
                      ),
                    );
                  },
                  child: ListTile(
                    subtitle:
                        Text('Conversation users: ${_conversations[index].id}'),
                    title: Text('Convo title: ${_conversations[index].title}'),
                  ),
                );
              },
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(10.0),
            child: Text(
              widget.user.username,
              style: TextStyle(
                  fontSize: 16,
                  color: getColorMap()["blue"],
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddConversationDialog(context),
        tooltip: 'Create New Conversation',
        child: const Icon(Icons.add),
      ),
    );
  }
}
