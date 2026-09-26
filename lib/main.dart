import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

import 'constants/api_constants.dart';
import 'constants/app_themes.dart';
import 'constants/app_router.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final debugToken = ApiConstants.appCheckDebugToken;
  await FirebaseAppCheck.instance.activate(
    providerAndroid: kDebugMode
        ? AndroidDebugProvider(debugToken: debugToken)
        : AndroidPlayIntegrityProvider(),
    providerApple: kDebugMode
        ? AppleDebugProvider(debugToken: debugToken)
        : AppleAppAttestProvider(),
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
