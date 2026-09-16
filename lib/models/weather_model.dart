class WeatherModel {
  final double temperature;
  final int humidity;
  final int weatherCode;
  final double rainProbability;

  const WeatherModel({
    required this.temperature,
    required this.humidity,
    required this.weatherCode,
    required this.rainProbability,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final current = json['current'] as Map<String, dynamic>? ?? {};
    final hourly = json['hourly'] as Map<String, dynamic>? ?? {};
    final rainProbList = hourly['precipitation_probability'] as List<dynamic>?;

    return WeatherModel(
      temperature: (current['temperature_2m'] as num?)?.toDouble() ?? 0.0,
      humidity: (current['relative_humidity_2m'] as num?)?.toInt() ?? 0,
      weatherCode: (current['weather_code'] as num?)?.toInt() ?? 0,
      rainProbability: rainProbList != null && rainProbList.isNotEmpty
          ? (rainProbList.first as num).toDouble()
          : 0.0,
    );
  }

  String get conditionText {
    if (weatherCode == 0) return 'Ensoleillé';
    if (weatherCode <= 3) return 'Partiellement nuageux';
    if (weatherCode <= 67) return 'Pluvieux';
    return 'Couvert';
  }
}