import 'package:flutter/material.dart';
import 'package:safe_note/screens/home.dart';
import 'package:safe_note/screens/note_details.dart';
import 'package:safe_note/screens/person_info.dart';
import 'package:safe_note/screens/personal_settings.dart';

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
      home: HomeScreen(),
      initialRoute: "/",
      routes: {
        "/note-details": (ctx) => NoteDetails(),
        "/personal-settings": (ctx) => SettingsScreen(),
        "/person-info": (ctx) => PersonalInfoScreen(),
      },
    );
  }
}
