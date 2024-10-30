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

  static Future<Account> createAccount(String fullName) async {
    var response = await dio.post('/accounts', data: {"full_name": fullName});
    var accountJson = response.data['data'];
    return Account.fromjson(accountJson);
  }

  static Future<Account> deposit(int id, int amount) async {
    var response =
        await dio.post('accounts/$id/deposit', data: {"amount": amount});
    var accountJson = response.data['data'];
    return Account.fromjson(accountJson);
  }

  static Future<Account> withdraw(int id, int amount) async {
    var response =
        await dio.post('accounts/$id/withdraw', data: {"amount": amount});
    var accountJson = response.data['data'];
    return Account.fromjson(accountJson);
  }

  static Future<Account> transfer(
      int id, int amount, String accountNumber) async {
    var response = await dio.post('accounts/$id/transfer',
        data: {'to_account_number': accountNumber, "amount": amount});
    var accountJson = response.data();
    return Account.fromjson(accountJson);
  }
}
