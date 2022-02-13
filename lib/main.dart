import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_note/providers/theme.dart';
import './screens/home.dart';
import './screens/note_details.dart';
import './screens/profile_form.dart';
import './screens/profile_settings.dart';
import './screens/auth_form.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ThemeProvider()),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    // application needed rebuild after get theme info from theme_provider
    final themeProvider = Provider.of<ThemeProvider>(context);
    // // this is not used
    // themeProvider.isDarkMode().then((value) {
    //   isDarkMode = value;
    //   // print(isDarkMode);
    // });
    // // print(themeProvider.isDark);
    

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Safe Note',
      theme: ThemeData(
        fontFamily: "Josefin",
        brightness: themeProvider.isDark ? Brightness.dark:Brightness.light,  // changes whole theme
        primarySwatch: Colors.blue,
        primaryColorDark: Colors.grey[900],
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
