import 'package:flutter/material.dart';
import 'package:recipe_app/pages/login_page.dart';
import 'package:recipe_app/pages/recipe_add_page.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/providers/user_provider.dart';
import 'package:recipe_app/recipe-widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home-page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isInit = true;
  @override
  void didChangeDependencies() {
    final userProvider = Provider.of<UserProvider>(context);

    if(isInit){
      setState(() {
        Provider.of<RecipeProvider>(context)
            .getAllRecipe(userProvider.currentUser.id)
            .then((value){
          setState(() {
            isInit = false;
          });
        });
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final recipeList = recipeProvider.recipeList;
    return Scaffold(
      backgroundColor: Colors.yellow[700],
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Icon(Icons.restaurant_menu),
            SizedBox(width: 10),
            Text(
              'Food Recipe',
            ),
          ],
        ),
        actions:[
          CircleAvatar(
            radius: 22,
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPage(),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      drawer: Drawer(
        elevation: 4,
        child: Container(
          color: Colors.red,
          child: ListView(
            children: [
              DrawerHeader(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 55),
                    child: Text(
                      'Welcome ${userProvider.currentUser}',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
              ),
              Divider(
                thickness: 2,
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                title: Text(''
                    'Sign Out',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: (){
                  userProvider.currentUser = null;
                  recipeProvider.clearRecipeList();
                  Navigator.pushReplacementNamed(context, LoginPage.routeName);
                },
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: recipeList.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: recipeList[i],
          child: Column(
            children: [
              RecipeWidget(),
              Divider(
                thickness: 1,
                color: Colors.black54,
              ),
            ]),
        )
      ),
    );
  }
}
