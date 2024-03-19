import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/models/user.dart';

class DBHelper{

    static Future<sql.Database> database()async {
      final dbPath = await sql.getDatabasesPath();  
      return sql.openDatabase(path.join(dbPath, 'recipes.db'),
          onCreate: (db, version) {
            db.execute('CREATE TABLE ${User.tableName} (id INTEGER PRIMARY KEY,'
                'username TEXT, password TEXT)',);
            db.execute('CREATE TABLE ${Recipe.tableName} (id INTEGER PRIMARY KEY,'
                'title TEXT, content TEXT, userId INTEGER, image TEXT)',);
          }, version: 1);
    }

    static Future<List<Map<String, dynamic>>> getData(String tableName)async{
      final db = await DBHelper.database();
      final result = db.query(tableName);
      return result;
    }
}