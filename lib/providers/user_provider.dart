import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'db_helper.dart';
import 'package:recipe_app/models/user.dart';


class UserProvider extends ChangeNotifier{

  User currentUser;

  Future<User> login(String username, String password) async{

    final response = await DBHelper.getData(User.tableName);
    if(response != null && response.length > 0){
      response.forEach((userMap) {
        User newUser = User.convertMapToObject(userMap);
        if(newUser.username == username && newUser.password == password){
          currentUser = newUser;
        }
      });
    }
      return currentUser; // if there is no match (username and password), this method will return null
    }

  Future<bool> isUserExist(String username) async{

    final response = await DBHelper.getData(User.tableName);
    if(response != null && response.length > 0){
      response.forEach((userMap) {
        User newUser = User.convertMapToObject(userMap);
        if(newUser.username == username){
         return true;
        }
      });
    }
    return false;
  }

  Future<User> addUser(User user) async{
    final db = await DBHelper.database();
    final id = await db.insert(
        User.tableName,
      User.convertObjectToMap(user),conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    db.close();
    currentUser = User(
      id: id,
      username: user.username,
      password: user.password,
    );
    return currentUser;
  }
}