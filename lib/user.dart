import 'package:flutter/cupertino.dart';

class User {
  final int userId;
  final String username;

  User({required this.userId, required this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['id'],
      username: json['username'],
    );
  }
}

class UserDataInherited extends InheritedWidget {
  final User data;

  const UserDataInherited({Key? key, required this.data, required Widget child})
      : super(key: key, child: child);

  static UserDataInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserDataInherited>();
  }

  @override
  bool updateShouldNotify(UserDataInherited oldWidget) {
    return oldWidget.data != data;
  }
}

class NewUser {
  final String username;

  NewUser({required this.username});

  Map<String, dynamic> toJson() => {
        'username': username,
      };
}

class ConversationUser {
  final int conversationId;
  final int userId;
  ConversationUser({required this.conversationId, required this.userId});
  factory ConversationUser.fromJson(Map<String, dynamic> json) {
    return ConversationUser(
      userId: json['user_id'],
      conversationId: json['conversation_id'],
    );
  }
}
