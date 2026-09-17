import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class ApiService {
  static const String _baseUrl = 'https://api.open-meteo.com/v1/forecast';

  Future<WeatherModel> fetchWeather({
    required double latitude,
    required double longitude,
  }) async {
    final uri = Uri.parse(
      '$_baseUrl?latitude=$latitude&longitude=$longitude'
      '&current=temperature_2m,relative_humidity_2m,weather_code'
      '&hourly=precipitation_probability'
      '&timezone=auto',
    );

    final response = await http.get(uri).timeout(
      const Duration(seconds: 8),
      onTimeout: () => throw Exception('Délai d’attente dépassé pour la météo.'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return WeatherModel.fromJson(data);
    } else {
      throw Exception('Erreur API météo (${response.statusCode}) : ${response.body}');
    }
  }
}