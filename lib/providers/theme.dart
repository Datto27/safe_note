import 'package:flutter/foundation.dart';


class ThemeProvider with ChangeNotifier {
  bool _darkTheme = false;
  get isDark {
    return _darkTheme;
  }
  void changeTheme() {
    _darkTheme = !_darkTheme;
    print("provider: theme --> ${_darkTheme}");
    notifyListeners();
  }
}