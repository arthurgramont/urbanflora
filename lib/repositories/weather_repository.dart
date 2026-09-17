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
    final position = await _locationService.getCurrentPosition();
    final weather = await _apiService.fetchWeather(
      latitude: position.latitude,
      longitude: position.longitude,
    );

    return (
      weather: weather,
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }
}
