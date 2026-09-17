import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/weather_model.dart';
import '../repositories/weather_repository.dart';

// Provider d'accès au repository
final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  return WeatherRepository();
});

// FutureProvider pour charger la météo locale courante
final currentWeatherProvider =
    FutureProvider<({WeatherModel weather, double latitude, double longitude})>(
      (ref) async {
        final repository = ref.watch(weatherRepositoryProvider);
        return await repository.getCurrentWeatherWithLocation();
      },
    );
