import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recipe_app/providers/db_helper.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:recipe_app/models/recipe.dart';


class RecipeProvider with ChangeNotifier{

  List<Recipe> _recipeList = [];

  List<Recipe> get recipeList{
    return [..._recipeList]; // the 3 dots with clone the _recipeList
  }

  void clearRecipeList(){
    _recipeList = [];
  }


  Recipe findById(int id){
    return _recipeList.firstWhere((todo) => todo.id == id);
  }

  Future<void> getAllRecipe(int userId) async{
      try{
        final response = await DBHelper.getData(Recipe.tableName);
        final List<Recipe> loadingRecipe = [];
        if(response != null && response.length > 0){
          response.forEach((recipeMap) {
            Recipe newRecipe = Recipe.convertMapToObject(recipeMap);
            if(newRecipe.userId == userId){
              loadingRecipe.add(newRecipe);
            }
          });
          _recipeList = loadingRecipe;
          notifyListeners();
        }
      }catch(error){
        print(error);
      }
  }

  Future<void> addRecipe(Recipe recipe) async {
    final db = await DBHelper.database();
    final id = await db.insert(Recipe.tableName, Recipe.convertObjectToMap(recipe),
    conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    db.close();
    if(id != null){
      Recipe newRecipe = Recipe(
        id: id,
        title: recipe.title,
        content: recipe.content,
        userId: recipe.userId,
        image: recipe.image
      );
      _recipeList.add(newRecipe);
      notifyListeners();
    }
  }

  Future<void> updateRecipe(Recipe recipe) async{
    final recipeIndex = recipeList.indexWhere(
            (element) => element.id == recipe.id,
    );
    
    final db = await DBHelper.database();
    await db.update(
      Recipe.tableName,
      Recipe.convertObjectToMap(recipe),
      where: 'id = ?',
      whereArgs: [recipe.id],
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    db.close();
    _recipeList[recipeIndex] = recipe;
    notifyListeners();
  }

  Future<void> deleteRecipe(int id) async {
    final db = await DBHelper.database();
    int result = await db.delete(
      Recipe.tableName,
        where:'id = ?',
        whereArgs: [id],
    );
    db.close();
    if(result > 0){
      _recipeList.removeWhere((element) => element.id == id);
    }
    notifyListeners();
  }

}