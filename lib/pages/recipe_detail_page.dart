import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:provider/provider.dart';

class RecipeDetailPage extends StatelessWidget {
  static const String routeName ='todo-detail-page';
  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context).settings.arguments;
    final recipeProvider = Provider.of<RecipeProvider>(context);

    Recipe selectedRecipe = recipeProvider.findById(id);
    TextEditingController titleController =
      TextEditingController(text: selectedRecipe.title);
    TextEditingController contentController =
      TextEditingController(text: selectedRecipe.content);

    return Scaffold(
      appBar: AppBar(
        title:Text('Update Recipe'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Recipe Name',
                ),
                controller: titleController,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ingredients',
                ),
                maxLines: 7,
                controller: contentController,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: IntrinsicWidth(
                      stepWidth: double.infinity,
                      child: ElevatedButton(
                        child: Text('Update Recipe'),
                        onPressed: (){
                          Recipe newRecipe = Recipe(
                            id:id,
                            title: titleController.text,
                            content: contentController.text,
                            userId: selectedRecipe.userId,
                          );
                          recipeProvider.updateRecipe(newRecipe);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: IntrinsicWidth(
                      stepWidth: double.infinity,
                      child: ElevatedButton(
                        child: Text('Cancel'),
                        onPressed: (){
                        Navigator.pop(context);
                      },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
