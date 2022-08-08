import 'package:flutter/material.dart';
import '../db/db_helper.dart';


class AutheticationForm extends StatefulWidget {
  @override
  State<AutheticationForm> createState() => _AutheticationFormState();
}

class _AutheticationFormState extends State<AutheticationForm> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  var userInfo;

  void initState() {
    super.initState();
    DatabaseHelper.instance.getUser() // comes from db helper
      .then((value) {
        // if user not exist move home screen
        if (value==null) {
          // print(value);
          Navigator.of(context).pushReplacementNamed("/home");
        }
        userInfo=value;
      })
      .catchError((err) {
        print(err);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("You can't use sqflite on web!"),
            backgroundColor: Colors.red,
          )
        );
        Navigator.of(context).pushReplacementNamed("/home");
      });
  }

  void authChecker(ctx) {
    // get db info if user exists and compare with entered values
    // print(userInfo!.username + "\n \n");
    if (userInfo!=null) {
      if (userInfo.username==usernameController.text && userInfo.password==passwordController.text) {
        Navigator.of(ctx).pushReplacementNamed("/home");
      } else {
        ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(
            content: Text("Username or Password is empty"),
            backgroundColor: Colors.red,
          )
        );
      }
    } else {
      Navigator.of(context).pushReplacementNamed("/home");
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(userInfo);

    return Scaffold( 
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
               SizedBox(height: MediaQuery.of(context).size.height*0.2,),
                // ----------------- title ----------------
                const Text(
                  "Enter Your Username and Password",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                RaisedButton(
                  child: const Text("Submit"),
                  padding: const EdgeInsets.all(18),
                  color: Colors.blueAccent,
                  onPressed: () => authChecker(context),
                )
            ],
          )
        ),
      ),
    );
  }
}