import '../services/httpie.dart';

class CoinApi {
  late HttpieService _httpService;
  String apiUrl = 'https://api.coingecko.com/api/v3';
  static const GET_LIST_COIN = '/coins/markets';
  void setHttpService(HttpieService httpService) {
    _httpService = httpService;
  }

  Future<HttpieResponse> getCurrency(
      {bool authenticatedRequest = true, String? vs_currency}) {
    return _httpService.get('$apiUrl$GET_LIST_COIN',
        appendAuthorizationToken: authenticatedRequest);
  }
}
