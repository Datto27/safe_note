import 'package:flutter/material.dart';
import 'package:safe_note/navigations/drawer_nav.dart';


class SettingsScreen extends StatefulWidget {
  SettingsScreen({ Key? key }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isdarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Personal Settings"),),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: <Widget>[
          // ---------------- theme controller -----------------
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Change Theme:", style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
                Switch(
                  value: _isdarkMode,
                  onChanged: (value) => setState(() {
                    _isdarkMode = value;
                  }),
                ),
              ],
            ),
          ),
          // ---------------- person's card ------------------
          Center(
            child: Container(
              height: 80,
              child: ListTile(
                leading: Icon(Icons.person, size: 80,),
                title: Text("Unknown Person", style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),)
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54, 
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  )
                ]
              ),
            )
          ),
          const SizedBox(height: 30,),
          Container(
            child: FlatButton(
              child: Text(
                "Add / Change Your Password and User", 
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed("/person-info");
              },
            ),
          )
        ],),
      ),
    );
  }
}