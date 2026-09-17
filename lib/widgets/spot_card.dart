import 'dart:io';

import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/spot_model.dart';

class SpotCard extends StatelessWidget {
  final SpotModel spot;
  final VoidCallback? onTap;

  const SpotCard({super.key, required this.spot, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Vignette photo locale
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 72,
                height: 72,
                child:
                    spot.imagePath.isNotEmpty &&
                        File(spot.imagePath).existsSync()
                    ? Image.file(File(spot.imagePath), fit: BoxFit.cover)
                    : Container(
                        color: AppColors.cardSubtle,
                        child: const Icon(
                          Icons.eco_rounded,
                          color: AppColors.secondary,
                          size: 32,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 14),

            // Textes et détails
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    spot.commonName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.neutralDark,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    spot.scientificName,
                    style: TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      color: AppColors.neutralDark.withValues(alpha: 0.7),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Chips Isar / Sync Cloud
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check,
                              size: 12,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Isar Cache',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        spot.isSynced
                            ? Icons.cloud_done_rounded
                            : Icons.cloud_queue_rounded,
                        size: 16,
                        color: spot.isSynced
                            ? AppColors.success
                            : AppColors.tertiary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
