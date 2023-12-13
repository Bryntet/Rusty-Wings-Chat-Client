import 'package:flutter/cupertino.dart';

class User {
  final int userId;
  final String username;

  User({required this.userId, required this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      username: json['username'],
    );
  }
}

class UserDataInherited extends InheritedWidget {
  final User data;

  UserDataInherited({Key? key, required this.data, required Widget child})
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
