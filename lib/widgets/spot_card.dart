import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../constants/app_colors.dart';
import '../models/spot_model.dart';

class SpotCard extends StatelessWidget {
  final SpotModel spot;
  final VoidCallback? onTap;

  const SpotCard({super.key, required this.spot, this.onTap});

  Future<File> _resolveImageFile(String path) async {
    // Si c'est déjà un chemin complet existant
    if (path.startsWith('/')) {
      final directFile = File(path);
      if (await directFile.exists()) return directFile;
    }
    // Sinon, on reconstitue le chemin dynamique dans les documents
    final appDir = await getApplicationDocumentsDirectory();
    final cleanName = path.split('/').last;
    return File('${appDir.path}/$cleanName');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.neutralDark.withValues(alpha: 0.08)),
      ),
      color: AppColors.surface,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Vignette photo avec résolution dynamique du dossier
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 72,
                  height: 72,
                  child: FutureBuilder<File>(
                    future: _resolveImageFile(spot.imagePath),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.existsSync()) {
                        return Image.file(snapshot.data!, fit: BoxFit.cover);
                      }
                      return Container(
                        color: AppColors.background,
                        child: const Icon(
                          Icons.eco,
                          color: AppColors.primary,
                          size: 32,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Détails textuels
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      spot.commonName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.neutralDark,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      spot.scientificName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: AppColors.neutralDark.withValues(alpha: 0.6),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            spot.isSynced ? 'Cloud Firebase' : 'Isar local',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: spot.isSynced
                                  ? AppColors.primary
                                  : Colors.orange[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                spot.isSynced ? Icons.cloud_done : Icons.cloud_off,
                size: 20,
                color: spot.isSynced ? AppColors.primary : Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
