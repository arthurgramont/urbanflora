import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../constants/app_colors.dart';
import '../../models/spot_model.dart';
import '../../providers/spot_provider.dart';
import '../../widgets/loading_overlay.dart';
import '../../services/gemini_service.dart';

import 'package:geolocator/geolocator.dart';

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
  final ImagePicker _picker = ImagePicker();

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
    } catch (_) {}
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<String> _saveImagePermanently(String sourcePath) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = 'spot_${DateTime.now().millisecondsSinceEpoch}.jpg';
    await File(sourcePath).copy('${appDir.path}/$fileName');
    return fileName;
  }

  Future<void> _processImage(String rawPath) async {
    setState(() {
      _isLoading = true;
      _loadingText = 'Sauvegarde de la photo...';
    });

    try {
      final fileName = await _saveImagePermanently(rawPath);
      final appDir = await getApplicationDocumentsDirectory();
      final fullPath = '${appDir.path}/$fileName';

      double lat = 0.0;
      double lon = 0.0;
      try {
        final lastKnown = await Geolocator.getLastKnownPosition();
        if (lastKnown != null) {
          lat = lastKnown.latitude;
          lon = lastKnown.longitude;
        }
      } catch (_) {}

      setState(() => _loadingText = 'Identification botanique (IA)...');
      Map<String, dynamic>? aiData;
      try {
        aiData = await GeminiService()
            .identifyPlant(fullPath)
            .timeout(const Duration(seconds: 15));
      } catch (e) {
        // ignore: avoid_print
        print('Erreur détaillée analyse IA : $e');
        aiData = null;
      }

      final isOnlineSuccess = aiData != null;

      final spot = SpotModel()
        ..cloudId = DateTime.now().millisecondsSinceEpoch.toString()
        ..commonName = aiData?['commonName'] ?? 'Spécimen en attente d’analyse'
        ..scientificName =
            aiData?['scientificName'] ?? 'Non identifié (hors-ligne)'
        ..family = aiData?['family'] ?? 'Flore spontanée'
        ..confidence = (aiData?['confidence'] as num?)?.toDouble() ?? 0.0
        ..ecologicalNiche =
            aiData?['ecologicalNiche'] ??
            'Capturé hors-ligne. En attente de synchronisation réseau.'
        ..imagePath = fileName
        ..latitude = lat
        ..longitude = lon
        ..districtName = 'Zone urbaine'
        ..temperature = 20.0
        ..humidity = 50
        ..rainRisk = 0.0
        ..createdAt = DateTime.now()
        ..isSynced = false;

      if (!mounted) return;
      setState(() => _isLoading = false);

      if (isOnlineSuccess) {
        context.pushReplacement(
          '/detail',
          extra: {'spot': spot, 'isNew': true},
        );
      } else {
        await ref.read(spotListProvider.notifier).addSpot(spot);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Mode hors-ligne : Spécimen enregistré dans votre herbier.',
            ),
            backgroundColor: AppColors.primary,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erreur : $e')));
    }
  }

  Future<void> _pickFromGallery() async {
    final xFile = await _picker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      await _processImage(xFile.path);
    }
  }

  Future<void> _captureWithCamera() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }
    final xFile = await _cameraController!.takePicture();
    await _processImage(xFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (_isInit && _cameraController != null)
            CameraPreview(_cameraController!)
          else
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.photo_camera_back_outlined,
                    size: 72,
                    color: AppColors.secondary,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Aucune caméra physique détectée',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Utilisez la galerie pour charger une photo de test.',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _pickFromGallery,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Sélectionner depuis la galerie'),
                  ),
                ],
              ),
            ),

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
                          onPressed: () => context.pop(),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.photo_library_outlined,
                        color: Colors.white,
                      ),
                      tooltip: 'Choisir depuis la galerie',
                      onPressed: _isLoading ? null : _pickFromGallery,
                    ),
                  ],
                ),
              ),
            ),
          ),

          if (_isInit && _cameraController != null)
            Center(
              child: SizedBox(
                width: 240,
                height: 240,
                child: const Center(
                  child: Icon(
                    Icons.center_focus_weak,
                    color: Colors.white54,
                    size: 48,
                  ),
                ),
              ),
            ),

          if (_isInit && _cameraController != null)
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 28),
                  child: GestureDetector(
                    onTap: _isLoading ? null : _captureWithCamera,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        color: AppColors.primary,
                      ),
                      child: const Icon(
                        Icons.eco,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),
                ),
              ),
            ),

          if (_isLoading) LoadingOverlay(message: _loadingText),
        ],
      ),
    );
  }
}
