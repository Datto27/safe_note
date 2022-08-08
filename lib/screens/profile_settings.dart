import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_note/providers/theme.dart';
import '../db/db_helper.dart';
import '../models/user.dart';
import '../navigations/drawer_nav.dart';

// ScreenArguments is made for pass route arguments clearly and take them easy from next screen
class PersonalInfoArgs {  // not used
  String option;
  User? userInfo;
  PersonalInfoArgs({required this.option, required this.userInfo});
}


class SettingsScreen extends StatefulWidget {
  SettingsScreen({ Key? key }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // bool _isdarkMode = false;
  var userInfo;

  @override
  void initState() {
    super.initState();
    DatabaseHelper.instance.getUser()
    .then((response) {
      // print("response first method: ${response}");
      setState(() {
        userInfo = response;
      });
    });
  }
  void deleteProfile(ctx) {
    // print("profile deleted");
    // if user exists delete it else show error message
    if (userInfo!=null) {
      DatabaseHelper.instance.deleteUser(userInfo.id);
      setState(() {
        userInfo=null;
      });
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          content: Text("Profile Doesn't Exist"),
          backgroundColor: Colors.red,
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // print("isDark: ${themeProvider.isDark}");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Settings", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: <Widget>[
          // ---------------- theme controller -----------------
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Change Theme:", style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
                Switch(
                  value: themeProvider.isDark,
                  onChanged: (value) => themeProvider.changeTheme(),
                ),
              ],
            ),
          ),
          // ---------------- person's card ------------------
          Center(
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                // color: Colors.white,
                color: themeProvider.isDark ? Colors.grey[900]:Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black54, 
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  )
                ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Icon(Icons.person, size: 80),
                  Flexible(
                    child: Text(
                      "${userInfo!=null ? userInfo?.username : 'Profile Not Created'}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  FlatButton.icon(
                    icon: const Icon(Icons.delete, color: Colors.red,),
                    label: const Text(
                      "Delete", 
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () => deleteProfile(context),
                  )
                ],
              ),
            )
          ),
          const SizedBox(height: 30,),
          Container(
            child: FlatButton(
              child: Text(
                "${userInfo==null?'Add':'Change'} Your Password and Username", 
                style: const TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                // check, if user alredy exists and only update its profile
                Navigator.of(context).pushNamed("/person-info", arguments: PersonalInfoArgs(
                  option: userInfo==null ? "Add":"Update",
                  userInfo: userInfo
                )
                // {
                //   "option": userInfo==null ? "add":"update",
                //   "userInfo": userInfo
                // }
                );
              },
            ),
          )
        ],),
      ),
    );
  }
}