
class User {
  int? id;
  String username;
  String password;
  User({
    this.id,
    required this.username,
    required this.password,
  });

   factory User.fromMap(Map<String, dynamic> json) => new User(
    id: json["id"],
    username: json["username"],
    password: json["password"],
  );
  // Map-dan json-shi; params: this.id ....
  Map<String, dynamic> convertJson() {
    return {
      "id": id,
      "username": username,
      "password": password,
    };
  }
}