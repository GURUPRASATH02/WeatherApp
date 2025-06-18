import 'package:http/http.dart' show Client;
import 'package:wheatherapp/module/WheatherData.dart';

class MyApi {
  static const _apiKey = 'a17247db727c7a9a9eecbaf0b6ffde16';
  static const _endpoint = 'https://api.openweathermap.org/data/2.5'; // ✅ Corrected

  Client client = Client();

  static MyApi? _instance;
  static MyApi getInstance() => _instance ??= MyApi();

  String _apiCall({required double lat, required double lon}) {
    return '$_endpoint/weather?lat=$lat&lon=$lon&APPID=$_apiKey&units=metric';
  }

  Future<WheatherData> getWeather({required double lat, required double lon}) async {
    final url = Uri.parse(_apiCall(lat: lat, lon: lon)); // ✅ Properly built URI
    final response = await client.get(
      url,
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      return WheatherData.deserialize(response.body); // ✅ Deserialize properly
    } else {
      throw Exception('Failed to load weather data: ${response.statusCode}');
    }
  }
}
