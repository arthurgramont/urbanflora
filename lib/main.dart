import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

import 'constants/app_themes.dart';
import 'constants/app_router.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseAppCheck.instance.activate(
    appleProvider: AppleProvider.debug,
    androidProvider: AndroidProvider.debug,
  );

  await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);

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
