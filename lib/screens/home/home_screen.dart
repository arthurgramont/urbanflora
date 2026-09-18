import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/app_colors.dart';
import '../../providers/spot_provider.dart';
import '../../widgets/spot_card.dart';

import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentTab = 1; // Onglet Herbier par défaut

  @override
  Widget build(BuildContext context) {
    final spotsState = ref.watch(spotListProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'My Herbarium',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.sync, color: AppColors.primary),
            tooltip: 'Synchroniser et analyser',
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Analyse IA et synchronisation en cours...'),
                  duration: Duration(seconds: 2),
                ),
              );

              final analyzedCount = await ref
                  .read(spotListProvider.notifier)
                  .analyzePendingSpots();
              final syncedCount = await ref
                  .read(spotListProvider.notifier)
                  .syncWithCloud();

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '$analyzedCount analysé(s) par l’IA • $syncedCount synchronisé(s) sur le Cloud',
                    ),
                    backgroundColor: AppColors.primary,
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: spotsState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (err, _) => Center(child: Text('Erreur Isar : $err')),
        data: (spots) {
          if (spots.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.local_florist_outlined,
                    size: 64,
                    color: AppColors.secondary,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Aucun spécimen répertorié',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Lancez le HUD Caméra pour scanner votre première plante.',
                    style: TextStyle(
                      color: AppColors.neutralDark.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: spots.length,
            itemBuilder: (ctx, index) {
              final spot = spots[index];
              return SpotCard(
                spot: spot,
                onTap: () => context.push('/detail', extra: spot),
              );
            },
          );
        },
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentTab,
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.secondary.withValues(alpha: 0.3),
        onDestinationSelected: (index) {
          if (index == 0) {
            context.push('/scan');
          } else if (index == 2) {
            context.push('/weather');
          } else if (index == 3) {
            context.push('/profile');
          } else {
            setState(() => _currentTab = index);
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.center_focus_strong),
            label: 'Scan HUD',
          ),
          NavigationDestination(icon: Icon(Icons.eco), label: 'Herbarium'),
          NavigationDestination(
            icon: Icon(Icons.wb_sunny_outlined),
            label: 'Weather',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
