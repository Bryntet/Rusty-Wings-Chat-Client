class Message {
  final int messageId;
  final int conversationId;
  final int userId;
  final DateTime timestamp;
  final String messageContent;

  Message({
    required this.messageId,
    required this.conversationId,
    required this.userId,
    required this.timestamp,
    required this.messageContent,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      messageId: json['id'],
      conversationId: json['conversation_id'],
      userId: json['user_id'],
      timestamp: DateTime.parse(json['timestamp']),
      messageContent: json['message_content'],
    );
  }
}

class NewMessage {
  final int conversationId;
  final int userId;
  final String messageContent;

  NewMessage({
    required this.conversationId,
    required this.userId,
    required this.messageContent,
  });

  Map<String, dynamic> toJson() {
    return {
      'conversation_id': conversationId,
      'user_id': userId,
      'message_content': messageContent,
    };
  }
}
