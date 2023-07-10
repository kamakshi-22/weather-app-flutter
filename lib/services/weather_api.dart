import 'package:http/http.dart' as http;
import 'package:weather_app/services/weather_model.dart';

class WeatherApi {

  static Future<WeatherModel> fetchData(String query) async {
    const apiKey = '1cdc594fa598910075ee4abec85549eb';
    String apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$query&appid=$apiKey';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonString = response.body;
        final weatherModel = weatherModelFromJson(jsonString);
        
        
        return weatherModel;
        // Process the data or update your UI
      } else {
        // Handle error response
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions
      throw Exception('Error: $error');
    }
  }
}
