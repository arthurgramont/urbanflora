import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class WeatherChip extends StatelessWidget {
  final double temperature;
  final int humidity;
  final double? rainRisk;

  const WeatherChip({
    super.key,
    required this.temperature,
    required this.humidity,
    this.rainRisk,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.wb_sunny_outlined,
            size: 20,
            color: AppColors.tertiary,
          ),
          const SizedBox(width: 8),
          Text(
            '${temperature.toStringAsFixed(0)}°C',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.neutralDark,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Humidité : $humidity%',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.neutralDark.withValues(alpha: 0.7),
            ),
          ),
          if (rainRisk != null) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.cardSubtle,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Pluie : ${rainRisk!.toStringAsFixed(0)}%',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
