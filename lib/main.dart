import 'package:flutter/material.dart';
import './screens/home.dart';
import './screens/note_details.dart';
import './screens/profile_form.dart';
import './screens/profile_settings.dart';
import './screens/auth_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AutheticationForm(),
      initialRoute: "/",
      routes: {
        "/home": (ctx) => HomeScreen(),
        "/note-details": (ctx) => NoteDetails(),
        "/personal-settings": (ctx) => SettingsScreen(),
        "/person-info": (ctx) => PersonalInfoScreen(),
      },
    );
  }
}
