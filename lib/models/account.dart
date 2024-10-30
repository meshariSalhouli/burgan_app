class Account {
  int id;
  String name;
  int userId;
  String number;
  int balance;
  DateTime updatedAt;
  DateTime createdAt;

  Account({
    required this.id,
    required this.name,
    required this.userId,
    required this.number,
    required this.updatedAt,
    required this.createdAt,
    this.balance = 0,
  });

  Account.fromjson(dynamic json)
      : id = json['id'],
        name = json["full_name"],
        userId = json["user_id"],
        number = json["number"],
        updatedAt = DateTime.parse(json["updated_at"]),
        createdAt = DateTime.parse(json["created_at"]),
        balance = json["balance"] ?? 0;

  String toString() =>
      "id: ${id.toString().padRight(4)}  number: ${number.toString().padRight(10)}  name: ${name.toString().padRight(10)} balance: $balance";
}
