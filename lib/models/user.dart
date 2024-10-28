class User {
  String username;
  String token;
  User({
    required this.username,
    required this.token,
  });

  User.fromjson(dynamic json)
      : username = json["user"],
        token = json["token"];

  Map<String, dynamic> toJson() {
    return {"user": username, "token": token};
  }
}
