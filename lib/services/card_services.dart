import 'package:burgan_app/models/card.dart';
import 'package:burgan_app/services/client.dart';

class CardServices {
  static Future<List<Cards>> list() async {
    var response = await dio.get('/accounts');
    var cardsJson = response.data['data']['account'] as List;
    return cardsJson.map(Cards.fromjson).toList();
  }
}
