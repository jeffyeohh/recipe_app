import 'package:flutter/material.dart';

// import 'package:flutter/foundation.dart';

class User extends ChangeNotifier{

  static const tableName= 'user';

  final int id;
  final String username;
  final String password;

  User({
    this.id,
    @required this.username,
    @required this.password,
  });

  static Map<String, dynamic> convertObjectToMap(User user){
    return{
      'id': user.id,
      'username': user.username,
      'password': user.password,
    };
  }

  static User convertMapToObject(Map<String,dynamic> userMap){
    return User(
      id: userMap['id'],
      username: userMap['username'],
      password: userMap['password'],
    );
  }
}