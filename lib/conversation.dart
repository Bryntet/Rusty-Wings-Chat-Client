class Conversation {
  final int id;
  Conversation({required this.id});

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['conversation_id'],
    );
  }
}

class NewConversation {
  final int sender;
  final int receiver;
  NewConversation({required this.sender, required this.receiver});
  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'receiver': receiver,
    };
  }
}