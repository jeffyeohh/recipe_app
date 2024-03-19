import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/pages/recipe_detail_page.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:provider/provider.dart';



class RecipeWidget extends StatefulWidget {
  @override
  _RecipeWidgetState createState() => _RecipeWidgetState();
}

class _RecipeWidgetState extends State<RecipeWidget> {
  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);
    final recipe = Provider.of<Recipe>(context);
    return Dismissible(
      background: Container(
        color: Colors.red,
      ),
      key: ValueKey(recipe.id),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36, vertical: 8),
        child: ListTile(
          title: Text(recipe.title,
            style: TextStyle(
            fontSize: 24,fontWeight: FontWeight.bold,
          ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete,
            size: 36,),
            color: Colors.red,
            onPressed: (){
              recipeProvider.deleteRecipe(recipe.id);
            },
          ),
          onTap: (){
            Navigator.pushNamed(context, RecipeDetailPage.routeName,arguments: recipe.id);
          },
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction){
        return showDialog(context: context, builder: (context)=>AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to remove this item?'),
          actions: [
            TextButton(child: Text('No'),onPressed: (){
              Navigator.pop(context,false);
              },
            ),
            TextButton(child: Text('Yes'),
              onPressed: (){
              Navigator.pop(context, true);
              },
            ),
          ],
        ),
        );
      },
      onDismissed: (direction){
        if(direction == DismissDirection.endToStart){
          recipeProvider.deleteRecipe(recipe.id);
        }
      },
    );
  }
}
