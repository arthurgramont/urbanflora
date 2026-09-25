import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_colors.dart';
import '../../providers/spot_provider.dart';
import '../../widgets/spot_card.dart';
import '../weather/weather_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _currentIndex == 1
          ? AppBar(
              title: const Text(
                'Mon Herbier',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.sync, color: AppColors.primary),
                  tooltip: 'Synchroniser',
                  onPressed: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Synchronisation et analyse en cours...'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    final analyzed = await ref
                        .read(spotListProvider.notifier)
                        .analyzePendingSpots();
                    final synced = await ref
                        .read(spotListProvider.notifier)
                        .syncWithCloud();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '$analyzed analysé(s) • $synced synchronisé(s)',
                          ),
                          backgroundColor: AppColors.primary,
                        ),
                      );
                    }
                  },
                ),
              ],
            )
          : null,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const SizedBox.shrink(),
          _buildHerbierTab(),
          const WeatherScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          height: 60,
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
          ),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(size: 22, color: AppColors.primary);
            }
            return const IconThemeData(size: 20);
          }),
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          elevation: 0,
          backgroundColor: AppColors.surface,
          indicatorColor: AppColors.primary.withValues(alpha: 0.12),
          onDestinationSelected: (index) {
            if (index == 0) {
              context.push('/scan');
            } else {
              setState(() {
                _currentIndex = index;
              });
            }
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.crop_free), label: 'Scan'),
            NavigationDestination(
              icon: Icon(Icons.eco_outlined),
              selectedIcon: Icon(Icons.eco),
              label: 'Herbier',
            ),
            NavigationDestination(
              icon: Icon(Icons.wb_sunny_outlined),
              selectedIcon: Icon(Icons.wb_sunny),
              label: 'Météo',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHerbierTab() {
    final spotsAsync = ref.watch(spotListProvider);

    return spotsAsync.when(
      data: (spots) {
        if (spots.isEmpty) {
          return const Center(
            child: Text(
              'Aucune plante enregistrée.\nScannez votre premier spécimen !',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () => ref.read(spotListProvider.notifier).loadSpots(),
          child: ListView.builder(
            itemCount: spots.length,
            padding: const EdgeInsets.only(top: 8, bottom: 24),
            itemBuilder: (context, index) {
              final spot = spots[index];
              return Dismissible(
                key: Key(spot.cloudId),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) {
                  ref.read(spotListProvider.notifier).deleteSpot(spot);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${spot.commonName} supprimé')),
                  );
                },
                child: SpotCard(
                  spot: spot,
                  onTap: () => context.push('/detail', extra: spot),
                ),
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Erreur : $e')),
    );
  }
}
