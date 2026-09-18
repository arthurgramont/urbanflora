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
      if (position != null) {
        lat = position.latitude;
        lon = position.longitude;
      }
    } catch (_) {}

    try {
      final weather = await _apiService.fetchWeather(
        latitude: lat,
        longitude: lon,
      );

      return (weather: weather, latitude: lat, longitude: lon);
    } catch (_) {
      final fallbackWeather = WeatherModel(
        temperature: 20.0,
        humidity: 50,
        rainProbability: 0.0,
        weatherCode: 0,
      );

      return (weather: fallbackWeather, latitude: lat, longitude: lon);
    }
  }
}
