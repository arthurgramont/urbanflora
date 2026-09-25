import 'dart:convert';
import 'dart:io';

import 'package:firebase_ai/firebase_ai.dart';

class GeminiService {
  late final GenerativeModel _model;

  GeminiService() {
    _model = FirebaseAI.googleAI().generativeModel(
      model: 'gemini-3.1-flash-lite',
      generationConfig: GenerationConfig(responseMimeType: 'application/json'),
    );
  }

  Future<Map<String, dynamic>> identifyPlant(String imagePath) async {
    final imageFile = File(imagePath);
    if (!await imageFile.exists()) {
      throw Exception('Fichier image introuvable: $imagePath');
    }

    final bytes = await imageFile.readAsBytes();

    final prompt = TextPart('''
Tu es un expert botaniste urbain. Analyse cette photo et retourne UNIQUEMENT un objet JSON valide avec les clés suivantes :
{
  "commonName": "Nom usuel en français ou anglais",
  "scientificName": "Nom binominal latin",
  "family": "Famille botanique",
  "confidence": 0.95,
  "ecologicalNiche": "Brève description (2 phrases) de son habitat urbain typique et de son rôle écologique",
  "traits": ["Ombre/Soleil", "Tolérance sécheresse", "Type de sol"]
}
Si la photo ne montre aucune plante, indique "Unknown" dans scientificName et un confidence de 0.0.
''');

    final response = await _model.generateContent([
      Content.multi([prompt, InlineDataPart('image/jpeg', bytes)]),
    ]);

    final text = response.text;
    if (text == null || text.isEmpty) {
      throw Exception('Réponse vide reçue du modèle');
    }

    return jsonDecode(text) as Map<String, dynamic>;
  }
}
