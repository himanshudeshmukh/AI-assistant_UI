/// Backend origin and API prefix for Spring Boot JSON endpoints.
///
/// Pass at build/run time, for example:
/// `flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8080`
///
/// - Android emulator → host machine: `http://10.0.2.2:8080`
/// - iOS simulator → host: `http://127.0.0.1:8080`
/// - Physical device: use your machine LAN IP, e.g. `http://192.168.1.5:8080`
library;

class ApiConfig {
  ApiConfig._();

  /// Server origin only (no path). Default targets Android emulator → localhost.
  static const String apiOrigin = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8080',
  );

  static const String apiVersionPrefix = '/api/v1';

  /// Full prefix for JSON routes, e.g. `http://10.0.2.2:8080/api/v1`.
  static String get apiPrefix => '$apiOrigin$apiVersionPrefix';
}
