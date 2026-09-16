import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'constants/app_themes.dart';

void main() {
  runApp(const ProviderScope(child: UrbanFloraApp()));
}

class UrbanFloraApp extends StatelessWidget {
  const UrbanFloraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UrbanFlora',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      home: const Scaffold(
        body: Center(
          child: Text('UrbanFlora - Setup En Cours'),
        ),
      ),
    );
  }
}