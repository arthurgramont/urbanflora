import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constants/app_themes.dart';
import 'constants/app_router.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Chargement des secrets (.env pour Gemini)
  await dotenv.load(fileName: ".env");

  // Initialisation de Firebase Cloud
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: UrbanFloraApp()));
}

class UrbanFloraApp extends StatelessWidget {
  const UrbanFloraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'UrbanFlora',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      routerConfig: appRouter,
    );
  }
}
