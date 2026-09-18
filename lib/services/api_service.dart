import 'package:dio/dio.dart';

import '../models/weather_model.dart';

class ApiService {
  final Dio _dio;

  ApiService({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: 'https://api.open-meteo.com/v1',
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
              responseType: ResponseType.json,
            ),
          );

  Future<WeatherModel> fetchWeather({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await _dio.get(
        '/forecast',
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          'current_': 'temperature_2m,relative_humidity_2m,weather_code,precipitation_probability',
          'timezone': 'auto',
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data as Map<String, dynamic>;
        return WeatherModel.fromJson(data);
      } else {
        throw Exception(
          'Réponse inattendue du serveur météo : ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['reason'] ?? e.message;
      throw Exception(
        'Erreur réseau Dio lors de la récupération de la météo : $errorMessage',
      );
    } catch (e) {
      throw Exception('Erreur inattendue: $e');
    }
  }
}
