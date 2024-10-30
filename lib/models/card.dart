class BankCard {
  int id;
  String name;
  int userId;
  int number;
  int balance;
  DateTime updatedAt;
  DateTime createdAt;
  DateTime expiryDate;
  int accountId;

  String get formattedNumber => magicCode().fold("", (e, sum) => sum + e);

  Iterable<String> magicCode() sync* {
    var numStr = number.toString();

    int i = 0;
    yield numStr[i++];
    yield numStr[i++];
    yield numStr[i++];
    yield numStr[i++];
    yield " ";
    yield numStr[i++];
    yield numStr[i++];
    yield numStr[i++];
    yield numStr[i++];
    yield " ";
    yield numStr[i++];
    yield numStr[i++];
    yield numStr[i++];
    yield numStr[i++];
    yield " ";
    yield numStr[i++];
    yield numStr[i++];
    yield numStr[i++];
    yield numStr[i++];
  }

  BankCard(
      {required this.id,
      required this.name,
      required this.userId,
      required this.number,
      required this.updatedAt,
      required this.createdAt,
      this.balance = 0,
      required this.expiryDate,
      required this.accountId});

  BankCard.fromjson(dynamic json)
      : id = json['id'],
        name = json["full_name"],
        userId = json["user_id"],
        number = json["number"],
        updatedAt = DateTime.parse(json["updated_at"]),
        createdAt = DateTime.parse(json["created_at"]),
        balance = json["balance"],
        expiryDate = DateTime.parse(json["expiry_date"]),
        accountId = json["account_id"];
}
