import 'package:flutter/material.dart';
import 'package:recipe_app/pages/home_page.dart';
import 'package:recipe_app/pages/login_page.dart';
import 'package:recipe_app/pages/signup_page.dart';
import 'package:recipe_app/pages/recipe_add_page.dart';
import 'package:recipe_app/pages/recipe_detail_page.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers:[
          ChangeNotifierProvider(
              create: (context) => RecipeProvider(),
          ),
          ChangeNotifierProvider(
              create: (context) => UserProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.red,
            accentColor: Colors.orange[900],
          ),
          initialRoute: LoginPage.routeName,
          routes: {
            HomePage.routeName:(context) => HomePage(),
            AddPage.routeName:(context) => AddPage(),
            RecipeDetailPage.routeName:(context) => RecipeDetailPage(),
            LoginPage.routeName:(context) => LoginPage(),
            SignUpPage.routeName:(context) => SignUpPage(),
          },
        ),
    );
  }
}
