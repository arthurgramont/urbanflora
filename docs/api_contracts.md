# Contrats d'intégration et API

UrbanFlora ne possède pas actuellement de serveur HTTP backend dédié. Les contrats ci-dessous documentent les intégrations réellement utilisées par l'application : Open-Meteo, Firebase Authentication, Cloud Firestore et Firebase AI / Gemini.

## 1. Open-Meteo

### Endpoint météo

```http
GET https://api.open-meteo.com/v1/forecast
```

### Paramètres envoyés

| Paramètre | Exemple | Description |
| --- | --- | --- |
| `latitude` | `48.8566` | Latitude de la position courante |
| `longitude` | `2.3522` | Longitude de la position courante |
| `current` | `temperature_2m,relative_humidity_2m,precipitation,weather_code` | Variables météo courantes demandées |
| `hourly` | `precipitation_probability` | Probabilité de précipitation horaire |
| `timezone` | `auto` | Fuseau horaire calculé pour la position |

Exemple de requête :

```http
GET https://api.open-meteo.com/v1/forecast?latitude=48.8566&longitude=2.3522&current=temperature_2m%2Crelative_humidity_2m%2Cprecipitation%2Cweather_code&hourly=precipitation_probability&timezone=auto
```

### Exemple de réponse Open-Meteo

```json
{
  "latitude": 48.86,
  "longitude": 2.35,
  "timezone": "Europe/Paris",
  "current": {
    "time": "2026-09-18T12:00",
    "temperature_2m": 21.4,
    "relative_humidity_2m": 58,
    "precipitation": 0.0,
    "weather_code": 1
  },
  "hourly": {
    "time": ["2026-09-18T12:00", "2026-09-18T13:00"],
    "precipitation_probability": [10, 8]
  }
}
```

### Mapping vers `WeatherModel`

```json
{
  "temperature": 21.4,
  "humidity": 58,
  "weatherCode": 1,
  "rainProbability": 10.0
}
```

- `temperature` provient de `current.temperature_2m`.
- `humidity` provient de `current.relative_humidity_2m`.
- `weatherCode` provient de `current.weather_code`.
- `rainProbability` utilise le premier élément de `hourly.precipitation_probability`.
- Si aucune probabilité n'est disponible, l'application estime la valeur à partir de `current.precipitation`.

## 2. Firebase Authentication

Firebase Authentication est appelé via le SDK Flutter, pas via une route HTTP écrite dans le projet.

### Création de compte

```dart
FirebaseAuth.instance.createUserWithEmailAndPassword(
  email: email,
  password: password,
);
```

Contraintes côté interface :

- l'e-mail et le mot de passe sont obligatoires ;
- le mot de passe doit comporter au moins 6 caractères à l'inscription ;
- la confirmation doit correspondre au mot de passe.

### Connexion

```dart
FirebaseAuth.instance.signInWithEmailAndPassword(
  email: email,
  password: password,
);
```

### Session anonyme

Lorsqu'une observation doit être synchronisée sans utilisateur courant :

```dart
FirebaseAuth.instance.signInAnonymously();
```

Le `uid` obtenu détermine le périmètre Firestore de la session invitée.

### Déconnexion

```dart
FirebaseAuth.instance.signOut();
```

## 3. Cloud Firestore

### Chemin des observations

```text
users/{uid}/spots/{cloudId}
```

- `uid` est fourni par Firebase Authentication.
- `cloudId` est généré par l'application à partir de l'horodatage de création.
- Le document est écrit avec `set`, ce qui rend la synchronisation idempotente pour un même `cloudId`.

### Contrat d'un document `SpotModel`

```json
{
  "cloudId": "1726651200000",
  "commonName": "Pissenlit",
  "scientificName": "Taraxacum officinale",
  "family": "Asteraceae",
  "confidence": 0.95,
  "ecologicalNiche": "Cette plante colonise les pelouses, les fissures et les sols remués. Elle fournit des ressources aux pollinisateurs et aux insectes urbains.",
  "imagePath": "spot_1726651200000.jpg",
  "latitude": 48.8566,
  "longitude": 2.3522,
  "districtName": "Zone urbaine",
  "temperature": 21.4,
  "humidity": 58,
  "rainRisk": 10.0,
  "createdAt": "2026-09-18T12:00:00.000Z"
}
```

`isSynced` est un état local Isar et n'est pas envoyé dans le document Firestore. `id` est également un identifiant local et n'est pas envoyé.

### Écriture d'une observation

Équivalent logique de l'opération réalisée par `SpotRepository` :

```text
users/{uid}/spots/{cloudId} -> set(document)
```

La sauvegarde locale est effectuée avant la tentative d'enregistrement dans le Cloud. En cas d'erreur réseau ou Firebase, l'observation reste dans Isar avec `isSynced: false`.

### Lecture des observations

```text
users/{uid}/spots -> get()
```

Lors d'un rechargement depuis le Cloud, les observations locales sont supprimées puis reconstruites à partir des documents reçus.

### Suppression d'une observation

```text
users/{uid}/spots/{cloudId} -> delete()
```

La copie Isar est supprimée avant la tentative de suppression distante.

### Réinitialisation de l'herbier

1. Suppression de toutes les observations locales Isar.
2. Lecture de `users/{uid}/spots`.
3. Suppression de chaque document Cloud.

### Règles Firestore recommandées

Le code applicatif suppose que chaque utilisateur ne peut accéder qu'à son propre sous-arbre. Exemple de base à adapter et tester dans Firebase Emulator Suite :

```text
match /users/{userId}/spots/{spotId} {
  allow read, write: if request.auth != null && request.auth.uid == userId;
}
```

Ce bloc est une orientation de sécurité, pas un remplacement d'une revue des règles en production.

## 4. Firebase AI / Gemini

### Service utilisé

Le service initialise le modèle suivant :

```text
FirebaseAI.googleAI().generativeModel(
  model: "gemini-3.1-flash-lite",
  responseMimeType: "application/json"
)
```

L'image est lue depuis le stockage local et envoyée sous forme de données binaires JPEG avec une instruction botanique.

### Contrat JSON demandé au modèle

```json
{
  "commonName": "Nom usuel en français ou anglais",
  "scientificName": "Nom binominal latin",
  "family": "Famille botanique",
  "confidence": 0.95,
  "ecologicalNiche": "Brève description de l'habitat urbain et du rôle écologique",
  "traits": [
    "Ombre/Soleil",
    "Tolérance sécheresse",
    "Type de sol"
  ]
}
```

### Exemple de réponse valide

```json
{
  "commonName": "Laiteron maraîcher",
  "scientificName": "Sonchus oleraceus",
  "family": "Asteraceae",
  "confidence": 0.87,
  "ecologicalNiche": "Cette plante pousse dans les sols remués, les pieds de murs et les friches urbaines. Elle participe aux ressources disponibles pour plusieurs insectes pollinisateurs.",
  "traits": [
    "Soleil",
    "Bonne tolérance à la sécheresse",
    "Sol riche et remué"
  ]
}
```

### Réponse lorsque l'image ne montre pas une plante

```json
{
  "commonName": "Unknown",
  "scientificName": "Unknown",
  "family": "Unknown",
  "confidence": 0.0,
  "ecologicalNiche": "Aucune plante identifiable sur l'image.",
  "traits": []
}
```

L'application lit principalement `commonName`, `scientificName`, `family`, `confidence` et `ecologicalNiche`. `traits` est demandé au modèle mais n'est pas actuellement persisté dans `SpotModel`.

## 5. Erreurs et comportements de repli

| Intégration | Erreur | Comportement actuel |
| --- | --- | --- |
| Caméra | Initialisation impossible | La galerie peut être utilisée |
| Gemini | Timeout ou réponse invalide | Création d'une observation hors-ligne avec confiance nulle |
| Firestore | Réseau ou permission refusée | L'observation reste locale et non synchronisée |
| Géolocalisation | Permission refusée ou service désactivé | Coordonnées `0.0` pour une capture, Paris pour la météo |
| Open-Meteo | Erreur HTTP ou réseau | Données météo de secours affichées |

## 6. Versioning des contrats

Les contrats sont actuellement internes à l'application et ne possèdent pas de version d'API publique. Toute modification des champs `SpotModel`, des paramètres Open-Meteo ou du prompt Gemini doit être accompagnée d'une mise à jour de ce document et des tests de parsing associés.
