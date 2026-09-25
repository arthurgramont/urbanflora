import 'package:dio/dio.dart';

import '../models/weather_model.dart';

class ApiService {
  final Dio _dio;

  ApiService({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ),
          );

  Future<WeatherModel> fetchWeather({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final lat = (latitude == 0.0 && longitude == 0.0) ? 48.8566 : latitude;
      final lon = (latitude == 0.0 && longitude == 0.0) ? 2.3522 : longitude;

      final response = await _dio.get(
        'https://api.open-meteo.com/v1/forecast',
        queryParameters: {
          'latitude': lat,
          'longitude': lon,
          'current':
              'temperature_2m,relative_humidity_2m,precipitation,weather_code',
          'hourly': 'precipitation_probability',
          'timezone': 'auto',
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data as Map<String, dynamic>;
        final current = data['current'] as Map<String, dynamic>? ?? {};

        double rainProb = 0.0;
        final hourly = data['hourly'] as Map<String, dynamic>?;
        if (hourly != null && hourly['precipitation_probability'] is List) {
          final probs = hourly['precipitation_probability'] as List;
          if (probs.isNotEmpty && probs.first != null) {
            rainProb = (probs.first as num).toDouble();
          }
        }

        return WeatherModel(
          temperature: (current['temperature_2m'] as num?)?.toDouble() ?? 0.0,
          humidity: (current['relative_humidity_2m'] as num?)?.toInt() ?? 0,
          rainProbability: rainProb > 0.0
              ? rainProb
              : ((current['precipitation'] as num?)?.toDouble() ?? 0.0) * 10,
          weatherCode: (current['weather_code'] as num?)?.toInt() ?? 0,
        );
      }

      throw Exception('Erreur API Open-Meteo: status ${response.statusCode}');
    } catch (e) {
      // ignore: avoid_print
      print('Erreur fetchWeather ApiService: $e');
      rethrow;
    }
  }
}
