import 'package:burgan_app/models/account.dart';
import 'package:burgan_app/services/account_services.dart';
import 'package:flutter/material.dart';

class Accountprovider extends ChangeNotifier {
  List<Account> accounts = [];

  int get balance =>
      accounts.map((e) => e.balance).fold(0, (sum, c) => sum + c);

  Future<void> get() async {
    accounts = await AccountServices.list();
    notifyListeners();
  }

  Future<void> createAccount(String fullName) async {
    Account newAccount = await AccountServices.createAccount(fullName);
    accounts.insert(0, newAccount);
    notifyListeners();
  }

  Future<void> deposit(int id, int amount) async {
    Account addingAmount = await AccountServices.deposit(id, amount);
    accounts[accounts.indexWhere((a) => a.id == id)] = addingAmount;
    notifyListeners();
  }

  Future<void> withdraw(int id, int amount) async {
    Account addingAmount = await AccountServices.withdraw(id, amount);
    accounts[accounts.indexWhere((a) => a.id == id)] = addingAmount;
    notifyListeners();
  }
}
