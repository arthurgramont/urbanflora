import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract final class ApiConstants {
  // Environment variable
  static String? get appCheckDebugToken => dotenv.env['FIREBASE_APP_CHECK_DEBUG_TOKEN'];
}