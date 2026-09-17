import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  late final GenerativeModel _model;

  GeminiService() {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('Clé GEMINI_API_KEY introuvable dans le fichier .env.');
    }

    _model = GenerativeModel(
      model: 'gemini-3.1-flash-lite',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
      ),
    );
  }

  Future<Map<String, dynamic>> identifyPlant(String imagePath) async {
    final imageBytes = await File(imagePath).readAsBytes();

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

    final imagePart = DataPart('image/jpeg', imageBytes);

    final response = await _model.generateContent([
      Content.multi([prompt, imagePart]),
    ]);

    final rawText = response.text;
    if (rawText == null || rawText.isEmpty) {
      throw Exception('Aucune réponse reçue de Gemini.');
    }

    return jsonDecode(rawText) as Map<String, dynamic>;
  }
}