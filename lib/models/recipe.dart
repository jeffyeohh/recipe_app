import 'package:flutter/material.dart';

class Recipe with ChangeNotifier{

  static const tableName = 'recipe';

  final int id;
  final String title;
  final String content;
  final int userId;
  final String image;

  Recipe({
    this.id,
    @required this.title,
    @required this.content,
    @required this.userId,
    @required this.image,
  });

  static Map<String, dynamic> convertObjectToMap(Recipe recipe){
    return {
      'id': recipe.id,
      'title': recipe.title,
      'content': recipe.content,
      'userId': recipe.userId,
      'image': recipe.image,

    };
  }

  static Recipe convertMapToObject(Map<String, dynamic> recipeMap){
    return Recipe(
      id: recipeMap['id'],
      title: recipeMap['title'],
      content: recipeMap['content'],
      userId: recipeMap['userId'],
      image: recipeMap['image'],
    );
  }
}