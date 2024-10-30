import 'package:flutter/material.dart';

class Cards {
  int id;
  String name;
  int userId;
  int number;
  int balance;
  DateTime updatedAt;
  DateTime createdAt;
  DateTime expiryDate;
  int accountId;

  Cards(
      {required this.id,
      required this.name,
      required this.userId,
      required this.number,
      required this.updatedAt,
      required this.createdAt,
      this.balance = 0,
      required this.expiryDate,
      required this.accountId});

  Cards.fromjson(dynamic json)
      : id = json['id'],
        name = json["full_name"],
        userId = json["user_id"],
        number = json["number"],
        updatedAt = DateTime.parse(json["updated_at"]),
        createdAt = DateTime.parse(json["created_at"]),
        balance = json["balance"],
        expiryDate = json["expiry_date"],
        accountId = json["account_id"];
}
