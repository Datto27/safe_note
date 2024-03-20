# safe_note

!!! have a bug during get a theme data

## Getting Started
- this application is used for save useful info,
- used sqflite for save data localy,
- you can add password and username,

- if user is regeistered and added password first it need is authenticate, else it will automaticaly move to home screen.


- home.dart - page where all saved notes are
- note_details.dart - for edit or create new note
- personal_form.dart - for add user profile
- personal_settings - controll user its settings and theme
- auth_form.dart - for authenticate user if it exists


### used main moduls:
  - sqflite for save data;
  - provider for state managment:
    - setted in main.dart with MultiProvider
    - used in profile_settings 

### UI: 
- theme is controlling into providers/theme.dart
- configuration is saved Store key-value data on disk with shared_references
