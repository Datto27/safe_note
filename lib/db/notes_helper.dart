import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:safe_note/models/note.dart';
import 'package:safe_note/models/user.dart';



class DatabaseHelper {
  // db init
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database = null;
  Future<Database> get database async {
    // if _database doesn't exists initialize database
    return _database ??= await _initDatabase();
    // _initDatabas() below function
  }

  Future<Database> _initDatabase() async {
    Directory documentDirecotory = await getApplicationDocumentsDirectory();
    String path = join(documentDirecotory.path, "notes.db");
    return openDatabase(
      path, version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes(
        id INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE user(
        id INTEGER PRIMARY KEY,
        username TEXT,
        password TEXT
      )
    ''');
  }

  Future<void> deleteDatabase() async {
    Directory docDir = await getApplicationDocumentsDirectory();
    databaseFactory.deleteDatabase(join(docDir.path, "notes.db"));
  }

  // ------------------ notes functions ----------------------
  Future<List<Note>> getNotes() async {
    Database db = await instance.database;
    var notes = await db.query("notes", orderBy: "title");
    // print("notes ==> ${notes}");
    List<Note> noteList = notes.isNotEmpty
      ? notes.map((n) => Note.fromMap(n)).toList()
      : [];
    return noteList;
  }

  Future<int> addNote(Note note) async {
    // shesabamisi note-is json pormatshi gadaqceba da db-shi shenaxva
    Database db = await instance.database;
    return await db.insert("notes", note.convertJson());
  }

  Future<int> removeNote(int id) async {
    Database db = await instance.database;
    return await db.delete("notes", where: "id=?", whereArgs: [id]);
  }

  Future<int> updateNote(Note note) async {
    Database db = await instance.database;
    return await db.update(
      "notes", 
      note.convertJson(),
      where: "id=?", whereArgs: [note.id]
    );
  }

  // ------------------- user functions -------------------
  Future<User?> getUser() async {
    Database db = await instance.database;
    var userInfo = await db.query("user");
    // print("user helper: ${userInfo}");
    User? user = userInfo.isNotEmpty
      ? User.fromMap(userInfo[0])
      : null;
    // print(user);
    return user;
  }
  Future<int> addUser(User user) async {
    Database db = await instance.database;
    return await db.insert("user", user.convertJson());
  }
  Future<int> updateUser(User user) async {
    print("(helper)updated user: ${user.id} ${user.username}");
    Database db = await instance.database;
    return await db.update(
      "user", 
      user.convertJson(), 
      where: "id=?", whereArgs: [user.id]
    );
  }
  Future<int> deleteUser(int id) async {
    Database db = await instance.database;
    return await db.delete("user", where: "id=?", whereArgs: [id]);
  }
}
