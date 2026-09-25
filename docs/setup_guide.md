# Guide d'installation et de lancement

Ce guide permet à un nouveau contributeur de cloner UrbanFlora, de préparer son environnement et de lancer l'application sur Android ou iOS.

## 1. Prérequis

### Outils communs

- Git
- Flutter avec un SDK Dart compatible avec `^3.13.3`
- Un éditeur compatible Flutter, par exemple VS Code ou Android Studio
- Une connexion réseau pour installer les dépendances et utiliser Firebase AI/Open-Meteo

Vérifier l'installation :

```bash
flutter --version
flutter doctor -v
git --version
```

### Android

Installer Android Studio avec :

- Android SDK
- Android SDK Platform-Tools
- Android SDK Command-line Tools
- Un émulateur Android ou un appareil USB avec le débogage activé

### iOS

Sur macOS, installer :

- Xcode depuis le Mac App Store
- Les outils de ligne de commande Xcode
- CocoaPods

Vérifier la cible iOS :

```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
pod --version
```

Un appareil réel est recommandé pour valider la caméra et la localisation.

## 2. Cloner le projet

Remplacer l'URL par celle du dépôt GitHub :

```bash
git clone <URL_DU_DEPOT>
cd urban_flora
```

Vérifier la branche active :

```bash
git status
git branch --show-current
```

## 3. Installer les dépendances Flutter

```bash
flutter pub get
```

Pour iOS, installer ou mettre à jour les pods :

```bash
cd ios
pod install
cd ..
```

## 4. Générer le code Isar

Le modèle `SpotModel` utilise Isar et possède un fichier généré `spot_model.g.dart`. Régénérer le code après une modification du modèle :

```bash
dart run build_runner build --delete-conflicting-outputs
```

Pendant le développement, le mode watch est possible :

```bash
dart run build_runner watch --delete-conflicting-outputs
```

## 5. Configurer Firebase

L'application attend les fichiers suivants :

```text
android/app/google-services.json
ios/Runner/GoogleService-Info.plist
lib/firebase_options.dart
```

Ces fichiers sont propres à l'environnement et sont ignorés par Git dans ce projet.

### Avec FlutterFire CLI

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

Sélectionner le projet Firebase et les plateformes Android/iOS. La commande génère ou met à jour `lib/firebase_options.dart` et les fichiers natifs associés.

### Services Firebase à activer

Dans la console Firebase :

1. Activer **Authentication**.
2. Activer le fournisseur **Email/Password**.
3. Activer **Anonymous** pour autoriser le mode invité.
4. Créer **Cloud Firestore**.
5. Configurer Firebase AI/Gemini selon les capacités disponibles pour le projet.
6. Définir et tester les règles Firestore.

Le chemin de stockage des observations est :

```text
users/{uid}/spots/{cloudId}
```

## 6. Vérifier les appareils

```bash
flutter devices
```

Pour voir les émulateurs disponibles :

```bash
flutter emulators
```

Lancer un émulateur Android si nécessaire :

```bash
flutter emulators --launch <id_emulateur>
```

## 7. Lancer l'application

Lancer automatiquement sur la cible disponible :

```bash
flutter run
```

Ou choisir une cible :

```bash
flutter run -d <device_id>
```

Exemples :

```bash
flutter run -d ios
flutter run -d android
```

Le parcours démarre sur `/onboarding`. Pour tester le scan sur un émulateur sans caméra exploitable, utiliser l'import depuis la galerie.

## 8. Vérifications fonctionnelles recommandées

### Parcours de base

1. Ouvrir l'application.
2. Passer l'onboarding ou appuyer sur **Démarrer**.
3. Créer un compte de test ou utiliser le mode invité.
4. Ouvrir **Scan**.
5. Importer une photo depuis la galerie.
6. Vérifier l'écran de résultat Gemini.
7. Enregistrer l'observation dans l'herbier.
8. Vérifier son statut local et Cloud.
9. Ouvrir l'onglet météo.
10. Vérifier le comportement avec et sans permission de localisation.

### Parcours hors-ligne

1. Désactiver le réseau.
2. Importer une photo.
3. Vérifier que l'observation est conservée avec une confiance nulle si Gemini est indisponible.
4. Réactiver le réseau.
5. Appuyer sur la synchronisation de l'herbier.
6. Vérifier l'analyse différée puis le statut synchronisé.

## 9. Tests et contrôles qualité

```bash
flutter analyze
flutter test
dart format lib test
```

Pour lancer uniquement le smoke test :

```bash
flutter test test/widget_test.dart
```

Avant une pull request, exécuter les trois commandes de contrôle et vérifier que les fichiers générés sont à jour.

## 10. Construire l'application

### Android APK

```bash
flutter build apk --release
```

### Android App Bundle

```bash
flutter build appbundle --release
```

### iOS

```bash
flutter build ipa --release
```

La signature Android/iOS, les certificats, les profils de provisioning et les secrets de publication doivent être configurés séparément pour chaque environnement.

## 11. Dépannage

### Firebase ne s'initialise pas

Vérifier les trois fichiers Firebase, le projet sélectionné par FlutterFire CLI, les identifiants d'application et la présence des services activés.

### Les pods iOS échouent

```bash
flutter clean
cd ios
pod deintegrate
pod install --repo-update
cd ..
flutter pub get
```

### Le code Isar est obsolète

```bash
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

### La caméra ne fonctionne pas

Tester sur un appareil réel et vérifier la permission caméra dans les réglages système. Sur émulateur, utiliser la galerie.

### La géolocalisation renvoie Paris ou zéro

Autoriser la localisation et vérifier que le service GPS est activé. Paris est le fallback météo ; une capture peut conserver `0.0` si aucune position n'est disponible.

### Gemini ou Firestore échoue

Vérifier la connexion, Firebase AI, les quotas, l'authentification anonyme et les règles Firestore. Le stockage local doit continuer à fonctionner même si la synchronisation distante échoue.

## 12. Checklist contributeur

- [ ] `flutter doctor -v` ne signale pas de blocage pour la cible utilisée.
- [ ] Les fichiers Firebase correspondent au bon projet.
- [ ] `flutter pub get` est terminé sans erreur.
- [ ] Le code généré Isar est à jour.
- [ ] `flutter analyze` passe.
- [ ] `flutter test` passe.
- [ ] Le parcours scan, herbier et synchronisation a été vérifié sur la cible concernée.
