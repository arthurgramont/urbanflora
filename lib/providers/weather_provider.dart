import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/weather_model.dart';
import '../repositories/weather_repository.dart';

final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  return WeatherRepository();
});

final currentWeatherProvider =
    FutureProvider<({WeatherModel weather, double latitude, double longitude})>(
      (ref) async {
        final repository = ref.watch(weatherRepositoryProvider);
        return await repository.getCurrentWeatherWithLocation();
      },
    );
