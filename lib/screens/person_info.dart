import 'package:flutter/material.dart';


class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    void saveInfo (ctx) {
      if (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
        print("saved");
      } else {
         ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(
            content: Text("Username or Password is empty"),
            backgroundColor: Colors.red,
          )
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text("Add Your Username and Password"),),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // ----------------- title ----------------
            Text(
              "Register Your Profile",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50,),
            // ----------------- form -----------------
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: "Username"),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
              // obscureText: true,
            ),
            SizedBox(height: 30,),
            RaisedButton(
              child: Text("Save"),
              padding: EdgeInsets.all(18),
              color: Colors.blueAccent,
              onPressed: () => saveInfo(context),
            ),
            SizedBox(height: 60,),  // for move up whole form
          ],
        ),
      ),
    );
  }
}