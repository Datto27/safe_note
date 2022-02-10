# safe_note

A new Flutter project.

## Getting Started
this application is used for save our usefull info,
used sqflite for save data localy,
flutter hooks is installed but not used,
you can add password and username,

if user is regeistered and had added password first it need is 
authenticate, else it will automaticaly move on home page.


home.dart - page where are all saved notes
note_details.dart - for edit or create new note
personal_form.dart - used for add user profile
personal_settings - controll user its settings and theme
auth_form.dart - for authenticate user if it exists


used main moduls:
  sqflite for save data;
  provider for state managment:
    setted in main.dart with MultiProvider
    used in profile_settings 

UI: 
theme is controlling into providers/theme.dart