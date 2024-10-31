import 'package:burgan_app/models/card.dart';
import 'package:burgan_app/services/client.dart';
import 'package:flutter/material.dart';

class CardServices {
  static Future<List<BankCard>> list() async {
    var response = await dio.get('/cards');
    var cardsJson = response.data['data']['cards'] as List;
    return cardsJson.map(BankCard.fromjson).toList();
  }

  static Future<BankCard> addCard(String number) async {
    var response = await dio.post('/cards', data: {
      "account_number": number,
      "expiry_date": "10/2027",
      "type": "debit"
    });
    var cardsJson = response.data['data'];
    return BankCard.fromjson(cardsJson);
  }
}
