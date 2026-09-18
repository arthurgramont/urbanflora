import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';

import '../../constants/app_colors.dart';
import '../../models/spot_model.dart';
import '../../providers/spot_provider.dart';

class SpotDetailScreen extends ConsumerWidget {
  final SpotModel spot;

  const SpotDetailScreen({super.key, required this.spot});

  Future<File> _resolveImageFile(String path) async {
    if (path.startsWith('/')) {
      final directFile = File(path);
      if (await directFile.exists()) return directFile;
    }
    final appDir = await getApplicationDocumentsDirectory();
    final cleanName = path.split('/').last;
    return File('${appDir.path}/$cleanName');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // En-tête avec la grande image de la plante
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            backgroundColor: AppColors.primary,
            leading: IconButton(
              icon: const CircleAvatar(
                backgroundColor: Colors.black45,
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              onPressed: () => context.pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: FutureBuilder<File>(
                future: _resolveImageFile(spot.imagePath),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.existsSync()) {
                    return Image.file(
                      snapshot.data!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
                  }
                  return Container(
                    color: AppColors.primary,
                    child: const Center(
                      child: Icon(Icons.eco, size: 80, color: Colors.white54),
                    ),
                  );
                },
              ),
            ),
          ),

          // Contenu descriptif
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Noms et badge de confiance
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              spot.commonName,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.neutralDark,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              spot.scientificName,
                              style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                color: AppColors.neutralDark.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.verified,
                              size: 16,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${(spot.confidence * 100).toStringAsFixed(0)} %',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Tag Famille
                  Chip(
                    backgroundColor: AppColors.surface,
                    side: BorderSide(
                      color: AppColors.neutralDark.withValues(alpha: 0.1),
                    ),
                    avatar: const Icon(
                      Icons.category_outlined,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    label: Text(
                      'Famille : ${spot.family}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Section Niche écologique / Habitat
                  const Text(
                    'Habitat et écologie urbaine',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.neutralDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      spot.ecologicalNiche,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: AppColors.neutralDark,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Données de contexte (Microclimat & Coordonnées)
                  const Text(
                    'Conditions au moment de la capture',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.neutralDark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          icon: Icons.thermostat,
                          title: 'Température',
                          value: '${spot.temperature.toStringAsFixed(1)} °C',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildInfoCard(
                          icon: Icons.water_drop_outlined,
                          title: 'Humidité',
                          value: '${spot.humidity} %',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          icon: Icons.umbrella_outlined,
                          title: 'Risque de pluie',
                          value: '${spot.rainRisk.toStringAsFixed(0)} %',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildInfoCard(
                          icon: Icons.location_on_outlined,
                          title: 'Position',
                          value: spot.latitude == 0.0 && spot.longitude == 0.0
                              ? 'Non géolocalisé'
                              : '${spot.latitude.toStringAsFixed(3)}, ${spot.longitude.toStringAsFixed(3)}',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Bouton d'action / confirmation
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await ref.read(spotListProvider.notifier).addSpot(spot);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Spécimen enregistré dans votre herbier !',
                              ),
                              backgroundColor: AppColors.primary,
                            ),
                          );
                          context.go('/');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      icon: const Icon(Icons.bookmark_added_outlined),
                      label: const Text(
                        'Enregistrer dans mon herbier',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: AppColors.primary),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.neutralDark,
            ),
          ),
        ],
      ),
    );
  }
}
