import 'package:flutter/material.dart';

class Note {
  int? id;
  String title;
  String description;
  Note({
    this.id,
    required this.title,
    required this.description,
  });

  // json-dan Map-shi
  // factory construcotr doesn't always create a new instance of its class
  factory Note.fromMap(Map<String, dynamic> json) => new Note(
    id: json["id"],
    title: json["title"],
    description: json["description"],
  );
  // Map-dan json-shi; params: this.id ....
  Map<String, dynamic> convertJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
    };
  }

}