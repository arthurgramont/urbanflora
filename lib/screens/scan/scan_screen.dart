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
import '../../services/api_service.dart';
import '../../services/gemini_service.dart';
import '../../services/location_service.dart';
import '../../widgets/loading_overlay.dart';

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
      _loadingText = 'Sauvegarde locale...';
    });

    try {
      // 1. Sauvegarde physique immédiate de l'image
      final fileName = await _saveImagePermanently(rawPath);

      // 2. Création de l'observation brute (Isar)
      final spot = SpotModel()
        ..cloudId = DateTime.now().millisecondsSinceEpoch.toString()
        ..commonName = 'Spécimen en attente d’analyse'
        ..scientificName = 'Non identifié'
        ..family = 'Flore spontanée'
        ..confidence = 0.0
        ..ecologicalNiche = 'Spécimen capturé sur le terrain. Analyse IA à lancer dès le retour du réseau.'
        ..imagePath = fileName
        ..latitude = 0.0
        ..longitude = 0.0
        ..districtName = 'Zone urbaine'
        ..temperature = 20.0
        ..humidity = 50
        ..rainRisk = 0.0
        ..createdAt = DateTime.now()
        ..isSynced = false;

      // 3. Écriture directe dans la base Isar
      await ref.read(spotListProvider.notifier).addSpot(spot);

      if (!mounted) return;
      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Photo enregistrée dans votre herbier !'),
          backgroundColor: AppColors.primary,
        ),
      );

      // 4. Retour direct à l'accueil
      context.pop();
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la sauvegarde : $e')),
      );
    }
  }

  Future<void> _pickFromGallery() async {
    final xFile = await _picker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      await _processImage(xFile.path);
    }
  }

  Future<void> _captureWithCamera() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized)
      return;
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

          // En-tête HUD
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
                                'GPS actif • Isar local',
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

          // Réticule central
          if (_isInit && _cameraController != null)
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

          // Déclencheur bas de page
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
