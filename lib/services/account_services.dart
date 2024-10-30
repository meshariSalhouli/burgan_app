import 'package:burgan_app/models/account.dart';
import 'package:burgan_app/services/client.dart';

class AccountServices {
  static Future<List<Account>> listShort() async =>
      ((await dio.get('/accounts')).data['data']['accounts'] as List)
          .map(Account.fromjson)
          .toList();

  static Future<List<Account>> list() async {
    var response = await dio.get('/accounts');
    var accountJson = response.data['data']['accounts'] as List;
    return accountJson.map(Account.fromjson).toList();
  }

  static Future<Account> deposit(int amount) async {
    var response = await dio.post('/deposit', data: amount);
    var accountJson = response.data['data'];
    return Account.fromjson(accountJson);
  }

  static Future<Account> withdraw(int amount) async {
    var response = await dio.post('/withdraw', data: amount);
    var accountJson = response.data['data'];
    return Account.fromjson(accountJson);
  }

  static Future<Account> transfer(int amount, int accountNumber) async {
    var response = await dio.post('/transfer');
    var accountJson = response.data['to_account_number'];
    return Account.fromjson(accountJson);
  }
}
