import 'package:burgan_app/models/card.dart';
import 'package:burgan_app/services/client.dart';

class CardServices {
  static Future<List<BankCard>> list() async {
    var response = await dio.get('/cards');
    var cardsJson = response.data['data']['cards'] as List;
    return cardsJson.map(BankCard.fromjson).toList();
  }
}
