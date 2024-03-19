import 'package:flutter/material.dart';
import 'package:recipe_app/models/user.dart';
import 'package:recipe_app/pages/home_page.dart';
import 'package:recipe_app/providers/user_provider.dart';
import 'package:provider/provider.dart';


class SignUpPage extends StatelessWidget {
  static const String routeName = 'signup-page';
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username'
            ),
            controller: usernameController,
          ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
              ),
              controller: passwordController,
            ),
            SizedBox(
              height: 20,
            ),
            IntrinsicWidth(
              stepWidth: double.infinity,
              child: ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text('Sign Up'),
                ),
                onPressed: () async{
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();

                  if(usernameController.text.isNotEmpty &&
                  passwordController.text.isNotEmpty){
                    User newUser = User(
                      username: usernameController.text,
                      password: passwordController.text,
                    );
                    final isUserExist = await userProvider.isUserExist(
                      usernameController.text,
                    );
                    if(isUserExist == false){
                      final response = await userProvider.addUser(newUser);
                      if(response.id != null){
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                            HomePage.routeName,
                              (route) => false,
                        );
                      }
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('User name exist'),
                          ),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
