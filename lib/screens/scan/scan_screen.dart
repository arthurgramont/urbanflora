import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../../constants/app_colors.dart';
import '../../services/gemini_service.dart';
import '../../services/location_service.dart';
import '../../services/api_service.dart';
import '../../models/spot_model.dart';
import '../../widgets/loading_overlay.dart';
import '../detail/spot_detail_screen.dart';

class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isInit = false;
  bool _isLoading = false;
  String _loadingText = '';

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras != null && _cameras!.isNotEmpty) {
        _cameraController = CameraController(
          _cameras!.first,
          ResolutionPreset.high,
          enableAudio: false,
        );
        await _cameraController!.initialize();
        if (mounted) setState(() => _isInit = true);
      }
    } catch (_) {
      // Géré silencieusement si émulateur sans caméra physique
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _processCapture() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    try {
      setState(() {
        _isLoading = true;
        _loadingText = 'Acquisition de la position & météo...';
      });

      // 1. Géolocalisation GPS
      final locationService = LocationService();
      final position = await locationService.getCurrentPosition();

      // 2. Météo locale via Open-Meteo REST API
      final apiService = ApiService();
      final weather = await apiService.fetchWeather(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      // 3. Prise de vue caméra
      setState(() => _loadingText = 'Capture du spécimen...');
      final xFile = await _cameraController!.takePicture();

      final appDir = await getApplicationDocumentsDirectory();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedImage = await File(xFile.path)
          .copy('${appDir.path}/$fileName');

      // 4. Analyse visuelle par Gemini Vision
      setState(() => _loadingText = 'Identification botanique (Gemini)...');
      final geminiService = GeminiService();
      final aiData = await geminiService.identifyPlant(savedImage.path);

      if (!mounted) return;

      final spot = SpotModel()
        ..cloudId = DateTime.now().millisecondsSinceEpoch.toString()
        ..commonName = aiData['commonName'] ?? 'Spécimen inconnu'
        ..scientificName = aiData['scientificName'] ?? 'Espèce indéterminée'
        ..family = aiData['family'] ?? 'Flore spontanée'
        ..confidence = (aiData['confidence'] as num?)?.toDouble() ?? 0.85
        ..ecologicalNiche = aiData['ecologicalNiche'] ?? 'Micro-habitat urbain.'
        ..imagePath = savedImage.path
        ..latitude = position.latitude
        ..longitude = position.longitude
        ..districtName = 'Zone urbaine'
        ..temperature = weather.temperature
        ..humidity = weather.humidity
        ..rainRisk = weather.rainProbability
        ..createdAt = DateTime.now()
        ..isSynced = false;

      setState(() => _isLoading = false);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => SpotDetailScreen(spot: spot)),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erreur : $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInit || _cameraController == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.secondary),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Preview Caméra
          CameraPreview(_cameraController!),

          // 2. HUD - Header statuts
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 22,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: AppColors.secondary,
                                size: 10,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'GPS Lock • Isar DB Ready',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.flash_off, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 3. Réticule central Stitch
          Center(
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.secondary.withValues(alpha: 0.8),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Center(
                child: Icon(
                  Icons.center_focus_weak,
                  color: Colors.white54,
                  size: 48,
                ),
              ),
            ),
          ),

          // 4. Déclencheur bas de page
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 28),
                child: GestureDetector(
                  onTap: _isLoading ? null : _processCapture,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      color: AppColors.primary,
                    ),
                    child: const Icon(Icons.eco, color: Colors.white, size: 36),
                  ),
                ),
              ),
            ),
          ),

          // 5. Loading Overlay pendant l'analyse
          if (_isLoading) LoadingOverlay(message: _loadingText),
        ],
      ),
    );
  }
}
