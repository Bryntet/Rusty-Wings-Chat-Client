class Conversation {
  final int id;
  final String title;

  Conversation({required this.id, required this.title});

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(id: json['id'], title: json['title']);
  }
}

class NewConversation {
  final int sender;
  final int receiver;
  final String title;

  NewConversation(
      {required this.sender, required this.receiver, required this.title});

  Map<String, dynamic> toJson() {
    return {'sender': sender, 'receiver': receiver, 'title': title};
  }
}
