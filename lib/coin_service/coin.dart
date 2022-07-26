import 'package:Okuna/coin_service/coin_api.dart';
import 'package:Okuna/coin_service/strings.dart';
import 'package:Okuna/services/httpie.dart';

import 'abstract_callback_resuilts.dart';

class CoinService {
  late HttpieService _httpieService;
  late CoinApi _coinApi;

  Future<void> getCurrency(
      {required String vs_currency, required CallBack callback}) async {
    HttpieResponse response = await _coinApi.getCurrency(
      vs_currency: vs_currency,
    );
    print(response.body);
    switch (response.statusCode) {
      case HttpStatus.success:
        callback.resuiltSuccess();
        break;
      default:
        callback.resuiltError();
        break;
    }
    return null;
  }
}
