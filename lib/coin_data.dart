import 'dart:convert';
import 'package:http/http.dart' as http;


const apiKey="9AA4C761-D28C-472E-A848-8760EF6519DF";
const url="https://rest.coinapi.io/v1/exchangerate";

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
// <Currency>?apikey=YOUR_API_KEY





const btcAverage="https://rest.coinapi.io/v1/exchangerate";
class CoinData {

  Map<String, String> cryptoPrices = {};
  Future getNetwork(String currency)async{
    for(String crypto in cryptoList){
    String urlRequest="$btcAverage/$crypto/$currency?apikey=$apiKey";
    http.Response response= await http.get(urlRequest);
    if(response.statusCode==200){
      var responseBody=jsonDecode(response.body);
      double decodedData= responseBody["rate"];
      cryptoPrices[crypto]= decodedData.toStringAsFixed(0);
    }else{
      print(response.body);
      throw "Problem processing this request";
    }
  }
  return cryptoPrices;
  }
}


