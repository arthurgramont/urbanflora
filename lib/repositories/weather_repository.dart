import '../models/weather_model.dart';
import '../services/api_service.dart';
import '../services/location_service.dart';

class WeatherRepository {
  final ApiService _apiService;
  final LocationService _locationService;

  WeatherRepository({ApiService? apiService, LocationService? locationService})
    : _apiService = apiService ?? ApiService(),
      _locationService = locationService ?? LocationService();

  Future<({WeatherModel weather, double latitude, double longitude})>
  getCurrentWeatherWithLocation() async {
    double lat = 48.8566;
    double lon = 2.3522;

    try {
      final position = await _locationService.getCurrentPosition();
      if (position != null &&
          position.latitude != 0.0 &&
          position.longitude != 0.0) {
        lat = position.latitude;
        lon = position.longitude;
      }
    } catch (e) {
      // ignore: avoid_print
      print('Info GPS WeatherRepository (fallback Paris utilisé): $e');
    }

    try {
      final weather = await _apiService.fetchWeather(
        latitude: lat,
        longitude: lon,
      );

      return (weather: weather, latitude: lat, longitude: lon);
    } catch (e) {
      // ignore: avoid_print
      print('Erreur WeatherRepository fetchWeather: $e');

      final fallbackWeather = WeatherModel(
        temperature: 18.5,
        humidity: 60,
        rainProbability: 10.0,
        weatherCode: 1,
      );

      return (weather: fallbackWeather, latitude: lat, longitude: lon);
    }
  }
}
