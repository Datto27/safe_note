import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeProvider with ChangeNotifier {
  bool _darkTheme = true;
  
  get isDark { // this is method. you can get it as themeProvider.isDark
    isDarkMode().then((value) => _darkTheme=value);
    print("theme provider --> ${_darkTheme}");
    return _darkTheme;
  }
  Future<bool> isDarkMode() async {
    // checks if isDarkMode is saved on disk and returns true, else false 
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool("isDarkMode");
    // print(isDarkMode);
    return isDarkMode==null ? false:true;
  }
  
  void changeTheme() async {
    // _darkTheme = !_darkTheme;
    // print("provider: theme --> ${_darkTheme}");
    // get data from disk and check if isDarkMode exists, set _darkTheme=true and add key-value on disk
    // else set _darkTheme=false and remove key-value from disk
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool("isDarkMode");
    if (isDarkMode==null) {
      prefs.setBool("isDarkMode", true);
      _darkTheme = true;
    } else {
      prefs.remove("isDarkMode");
      _darkTheme = false;
    }
    // print("changed theme: ${prefs.getBool('isDarkMode')}");
    notifyListeners(); // for accept state changes
  }
}