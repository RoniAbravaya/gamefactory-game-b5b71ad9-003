/// Analytics configuration for testLast-puzzle-03
class AnalyticsConfig {
  AnalyticsConfig._();

  /// Game identifier
  static const String gameId = '207d8a03-6c61-4b9b-84fe-0bc54d6a15cf';
  
  /// App version
  static const String appVersion = '1.0.0';
  
  /// Backend URL for event forwarding
  static const String backendUrl = String.fromEnvironment(
    'BACKEND_URL',
    defaultValue: 'https://api.gamefactory.com',
  );
  
  /// API key for backend authentication
  static const String apiKey = String.fromEnvironment(
    'API_KEY',
    defaultValue: '',
  );
  
  /// Whether to forward events to backend
  static const bool forwardToBackend = true;
  
  /// Debug mode logging
  static const bool debugLogging = bool.fromEnvironment('DEBUG', defaultValue: false);
}
