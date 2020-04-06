import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const String apiUrl = 'https://rest.coinapi.io/v1';
const String apiKey = '3B3A698A-936D-4656-8399-529A11122A92';

class CoinData {
  Future getCoinData(String currency) async {
    Map<String, String> cryptoPrices = {};

    for (var crypto in cryptoList) {
      String url = '$apiUrl/exchangerate/$crypto/$currency?apikey=$apiKey';
      http.Response response = await http.get(url);

      if (response.statusCode != 200) {
        print(response.statusCode);
        throw 'Unexpected issue while getting data from CoinAPI.';
      }

      String data = response.body;
      var decodedData = jsonDecode(data);
      double price = decodedData['rate'];
      cryptoPrices[crypto] = price.toStringAsFixed(0);
    }

    return cryptoPrices;
  }
}
