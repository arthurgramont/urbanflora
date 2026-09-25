# UrbanFlora

> L'herbier numérique intelligent pour explorer, identifier et comprendre la flore urbaine.

UrbanFlora est une application mobile Flutter qui transforme une photo de plante en observation botanique documentée. Elle combine identification par IA, géolocalisation, météo locale, stockage hors-ligne et synchronisation Cloud pour accompagner les observations sur le terrain.

## Pourquoi UrbanFlora ?

La flore spontanée est présente partout en ville, mais reste souvent difficile à identifier et à documenter. UrbanFlora propose un parcours simple : capturer, comprendre, conserver et retrouver ses observations.

## Fonctionnalités principales

- Scanner une plante avec la caméra ou importer une photo depuis la galerie.
- Obtenir une identification botanique avec Gemini via Firebase AI.
- Enregistrer les observations dans un herbier numérique local.
- Continuer à collecter hors-ligne grâce à Isar.
- Synchroniser les observations avec Firestore.
- Associer une position et les conditions météo à chaque capture.
- Consulter le nom commun, le nom scientifique, la famille et la niche écologique.
- Visualiser les statistiques de collecte et ouvrir le lieu dans Google Maps.
- Créer un compte ou utiliser le mode invité Firebase.

## Aperçu du parcours

```text
Onboarding -> Authentification -> Scan -> Identification IA
                                      |                  |
                                      +-> Herbier local -+-> Synchronisation Cloud
```

## Stack technique

| Domaine | Technologie |
| --- | --- |
| Application | Flutter / Dart |
| Navigation | go_router |
| État | Riverpod |
| Base locale | Isar |
| Authentification et Cloud | Firebase Authentication, Cloud Firestore |
| Intelligence artificielle | Firebase AI / Gemini |
| Météo | Open-Meteo |
| Appareil | Camera, Image Picker, Geolocator |

## Démarrage rapide

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

La configuration complète, étape par étape, se trouve dans le [guide d'installation](docs/setup_guide.md).

## Documentation

- [Guide d'installation et de lancement](docs/setup_guide.md)
- [Architecture et flux de données](docs/architecture.md)
- [Contrats d'intégration et exemples JSON](docs/api_contracts.md)

## État du projet

Le projet est une application Flutter fonctionnelle ciblant Android et iOS. Le mode hors-ligne couvre le stockage des observations ; les images restent actuellement stockées dans le répertoire privé de l'appareil et ne sont pas envoyées dans Firebase Storage.

Avant une mise en production, il faudra notamment renforcer les règles Firestore, déplacer la gestion des secrets vers la CI/CD et compléter la couverture de tests des repositories et de la synchronisation.

## Développement

```bash
flutter analyze
flutter test
dart format lib test
```

Un appareil réel est recommandé pour tester la caméra et la géolocalisation. Un émulateur permet toutefois de tester l'import depuis la galerie et les principaux écrans.

## Ressources

- [Flutter](https://docs.flutter.dev/)
- [Firebase for Flutter](https://firebase.google.com/docs/flutter/setup)
- [Firebase AI](https://firebase.google.com/docs/ai-logic)
- [Open-Meteo](https://open-meteo.com/)
- [Riverpod](https://riverpod.dev/)
- [Isar](https://isar.dev/)
