import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../models/user.dart';
import './profile_settings.dart';


class PersonalInfoScreen extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // [userId] - means that userId is not always usefull. used for default value
  void saveInfo (ctx, option, [userId]) {
    if (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      if (option == "Add") {
        DatabaseHelper.instance.addUser(User(
          username: usernameController.text,
          password: passwordController.text,
        ));
      } else {
        // print("user updated ${userId}");
        DatabaseHelper.instance.updateUser(User(
          id: userId,
          username: usernameController.text,
          password: passwordController.text,
        ));
      }
      Navigator.of(ctx).pushReplacementNamed("/personal-settings");
    } else {
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(
            content: Text("Username or Password is empty"),
            backgroundColor: Colors.red,
          )
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    // coming from personal_settings for make conditional rendering, update/add user
    final routeArgs = ModalRoute.of(context)!.settings.arguments as PersonalInfoArgs;
    // print(routeArgs.userInfo);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Register", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height*0.2,),
              // ----------------- title ----------------
              Text(
                "${routeArgs.option} Your Profile",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50,),
              // ----------------- form -----------------
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: "Username"),
              ),
              const SizedBox(height: 20,),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                // obscureText: true,
              ),
              const SizedBox(height: 30,),
              // conditional rendering if args.option=="Add" add new user
              // else update existed user
              routeArgs.option=="Add" 
              ? RaisedButton(
                child: const Text("Add"),
                padding: const EdgeInsets.all(18),
                color: Colors.blueAccent,
                onPressed: () => saveInfo(context, routeArgs.option),
              )
              : RaisedButton(
                child: const Text("Update"),
                padding: const EdgeInsets.all(18),
                color: Colors.blueAccent,
                onPressed: () => {}, //saveInfo(context, routeArgs.option, routeArgs.userInfo.id)
              ),
            ],
          ),
        ),
      ),
    );
  }
}