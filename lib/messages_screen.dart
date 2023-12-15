import 'package:chat_app_client/theme.dart';
import 'package:chat_app_client/user.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_client/api_service.dart';
import 'package:chat_app_client/message.dart';
import 'package:chat_app_client/conversation.dart';
import 'dart:async';

class MessagesScreen extends StatefulWidget {
  final Conversation conversation;
  final User user;

  const MessagesScreen(
      {Key? key, required this.conversation, required this.user})
      : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  Timer? _timer;
  final colorMap = getColorMap();

  final ApiService _apiService = ApiService('http://localhost:3000');
  List<Message> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  Map<int, String> userIdToUsernameMap = {};

  @override
  void initState() {
    super.initState();
    _loadMessages();
    _loadUsernames();
    _timer = Timer.periodic(const Duration(milliseconds: 500),
        (Timer t) => _checkForUpdateMessages());
  }

  void _sendMessage(String message) async {
    if (message != "") {
      await _apiService.createMessage(NewMessage(
          conversationId: widget.conversation.id,
          userId: widget.user.userId,
          messageContent: message));
      _loadMessages();
      _textController.clear();
      _focusNode.requestFocus(); // Refocus the text field
    }
  }

  void _loadMessages() async {
    List<Message> messages = await _apiService.getMessages(widget.conversation);
    _updateMessages(messages);
  }

  void _checkForUpdateMessages() async {
    List<Message> messages = await _apiService.getMessages(widget.conversation);
    if (_messages != messages) {
      _updateMessages(messages);
    }
  }

  void _updateMessages(List<Message> messages) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    setState(() {
      _messages = messages;
    });
    _loadUsernames();
  }

  void _loadUsernames() async {
    Set<int> userIds = _messages.map((message) => message.userId).toSet();
    List<Future> futures = [];

    for (int userId in userIds) {
      futures.add(_apiService.getUser(userId.toString()).then((user) {
        if (user != null) {
          userIdToUsernameMap[userId] = user.username;
        }
      }));
    }
    await Future.wait(futures);

    setState(() {});
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                Message message = _messages[index];
                return ListTile(
                  title: Text(message.messageContent),
                  leading: Text(message.userId == widget.user.userId
                      ? 'You:'
                      : "${userIdToUsernameMap[message.userId]}:"),
                  titleTextStyle: const TextStyle(),
                  leadingAndTrailingTextStyle: TextStyle(
                      color: colorMap["lavender"]!,
                      fontWeight: FontWeight.bold),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textController,
              focusNode: _focusNode,
              autofocus: true,
              decoration: InputDecoration(
                  labelText: 'Write here :)',
                  labelStyle: TextStyle(
                    color: colorMap['text'],
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: colorMap['surface0']!,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: colorMap['surface0']!,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: colorMap['lavender']!,
                    ),
                  ),
                  focusColor: colorMap['lavender'],
                  filled: false),
              style: TextStyle(
                fontSize: 14,
                color: colorMap['text'],
              ),
              onSubmitted: (value) {
                _sendMessage(value);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _sendMessage(_textController.text);
        },
        child: const Icon(Icons.send),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
