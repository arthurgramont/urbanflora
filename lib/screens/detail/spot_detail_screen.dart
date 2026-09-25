import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_colors.dart';
import '../../models/spot_model.dart';
import '../../providers/spot_provider.dart';

class SpotDetailScreen extends ConsumerWidget {
  final SpotModel spot;
  final bool isNewCapture;

  const SpotDetailScreen({
    super.key,
    required this.spot,
    this.isNewCapture = false,
  });

  Future<String> _resolveImagePath(String path) async {
    if (path.startsWith('/')) return path;
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/$path';
  }

  Future<void> _openInMaps(double lat, double lon) async {
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lon',
    );
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      // ignore: avoid_print
      print('Impossible d’ouvrir Maps : $e');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(spot.commonName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (isNewCapture) {
              context.go('/');
            } else {
              context.pop();
            }
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              spot.isSynced ? Icons.cloud_done : Icons.cloud_off,
              color: spot.isSynced ? AppColors.primary : Colors.orange,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<String>(
              future: _resolveImagePath(spot.imagePath),
              builder: (context, snapshot) {
                if (snapshot.hasData && File(snapshot.data!).existsSync()) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      File(snapshot.data!),
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  );
                }
                return Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Icon(Icons.image_not_supported, size: 48),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Text(
              spot.commonName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              spot.scientificName,
              style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Chip(
              label: Text(spot.family),
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              labelStyle: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Conditions lors de la capture',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildMetricCard(
                  Icons.thermostat,
                  '${spot.temperature.toStringAsFixed(1)} °C',
                  'Température',
                ),
                const SizedBox(width: 8),
                _buildMetricCard(
                  Icons.water_drop,
                  '${spot.humidity} %',
                  'Humidité',
                ),
                const SizedBox(width: 8),
                _buildMetricCard(
                  Icons.umbrella,
                  '${spot.rainRisk.toStringAsFixed(0)} %',
                  'Pluie',
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Rôle écologique urbain',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              spot.ecologicalNiche,
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
            const SizedBox(height: 24),

            if (!isNewCapture && spot.latitude != 0.0 && spot.longitude != 0.0)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.map_outlined),
                  label: const Text('Voir le lieu de capture sur la carte'),
                  onPressed: () => _openInMaps(spot.latitude, spot.longitude),
                ),
              ),

            if (isNewCapture)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.bookmark_add_outlined),
                  label: const Text(
                    'Enregistrer dans mon herbier',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    await ref.read(spotListProvider.notifier).addSpot(spot);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Spécimen ajouté à votre herbier !'),
                          backgroundColor: AppColors.primary,
                        ),
                      );
                      context.go('/');
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(IconData icon, String value, String label) {
    return Expanded(
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              Icon(icon, color: AppColors.primary, size: 22),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                label,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
