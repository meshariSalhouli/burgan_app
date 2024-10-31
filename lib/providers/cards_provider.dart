import 'package:burgan_app/models/card.dart';
import 'package:burgan_app/services/card_services.dart';
import 'package:flutter/material.dart';

class BankCardProvider extends ChangeNotifier {
  List<BankCard> cards = [];

  Future<void> get() async {
    cards = await CardServices.list();
    notifyListeners();
  }

  Future<void> addCard(String number) async {
    BankCard newCard = await CardServices.addCard(number);
    cards.insert(0, newCard);
    notifyListeners();
  }
}
